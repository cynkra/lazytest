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

  first_run <- run_lazytest(pkg_dir = pkg_dir, lazytest_dir = here::here())

  expect_true(file.exists(file.path(pkg_dir, ".lazytest")))
  # expect_snapshot_file didn't record anything?!
  expect_equal(
    readLines(file.path(pkg_dir, ".lazytest")),
    "blip"
  )
  expect_equal(
    as.data.frame.testthat_results(first_run$get_result())[,1],
    c("test-blip.R", "test-blop.R")
  )

  second_run <- run_lazytest(pkg_dir = pkg_dir, lazytest_dir = here::here())
  expect_equal(
    as.data.frame.testthat_results(second_run$get_result())[,1],
    c("test-blip.R")
  )

  # Now fix test!
  edit_test("blip", passing_test_lines(), pkg_dir = pkg_dir)
  new_run <- run_lazytest(pkg_dir = pkg_dir, lazytest_dir = here::here())
  expect_equal(
    as.data.frame.testthat_results(second_run$get_result())[,1],
    c("test-blip.R")
  )
  expect_false(file.exists(file.path(pkg_dir, ".lazytest")))

  run_lazytest(pkg_dir = pkg_dir, lazytest_dir = here::here())
  expect_snapshot(readLines(file.path(pkg_dir, "lazytest-msg")))
})
