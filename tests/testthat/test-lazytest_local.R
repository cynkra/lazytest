test_that("lazytest_local() works", {
  withr::local_options(usethis.quiet = TRUE)

  pkg_parent_dir <- withr::local_tempdir()
  pkg_dir <- fledge::create_demo_project(dir = pkg_parent_dir, news = FALSE)
  usethis::with_project(path = pkg_dir, {
    usethis::use_testthat()
    usethis::use_test("blop")
    usethis::use_test("blip")
  }, force = TRUE)
  edit_test("blop", passing_test_lines(), pkg_dir = pkg_dir)
  edit_test("blip", failing_test_lines(), pkg_dir = pkg_dir)

  lazytest_dir <- here::here()

  # convoluted way to run the tests
  # without their results being reported for this test file
  withr::with_dir(pkg_dir, {
    process <- callr::r_bg(function(lazytest_dir) {
      pkgload::load_all(lazytest_dir)
      lazytest::lazytest_local()
    },
      args = list(lazytest_dir = lazytest_dir)
    )
    process$wait()
  })

  expect_true(file.exists(file.path(pkg_dir, ".lazytest")))
  expect_snapshot_file(file.path(pkg_dir, ".lazytest"))
})
