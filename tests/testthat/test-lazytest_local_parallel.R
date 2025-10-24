test_that("lazytest_local() works if all tests are successful", {
  skip_on_covr()
  skip_if_not_installed("here")
  skip_if_not_installed("usethis")
  withr::local_options(usethis.quiet = TRUE)

  # set up test package ----
  pkg_parent_dir <- withr::local_tempdir()
  pkg_dir <- file.path(pkg_parent_dir, "tea")
  usethis::create_package(pkg_dir)
  usethis::with_project(path = pkg_dir, {
    usethis::use_testthat()
    usethis::use_test("blop")
    usethis::use_test("blip")
  })
  edit_test("blop", passing_test_lines(), pkg_dir = pkg_dir)
  edit_test("blip", failing_test_lines(), pkg_dir = pkg_dir)

  # run tests, including one failing test, twice ----
  first_run <- run_lazytest(
    pkg_dir = pkg_dir,
    lazytest_dir = lazytest_dir(),
    parallel = TRUE
  )

  expect_true(file.exists(file.path(pkg_dir, ".lazytest")))
  # expect_snapshot_file didn't record anything?!
  expect_equal(
    brio::read_lines(file.path(pkg_dir, ".lazytest")),
    "blip"
  )

  edit_test("blip", passing_test_lines(), pkg_dir = pkg_dir)

  second_run <- run_lazytest(
    pkg_dir = pkg_dir,
    lazytest_dir = lazytest_dir(),
    parallel = TRUE
  )
  expect_equal(
    sort(executed_test_files(second_run)),
    c("test-blip.R", "test-blop.R")
  )

  third_run <- run_lazytest(
    pkg_dir = pkg_dir,
    lazytest_dir = lazytest_dir(),
    parallel = TRUE
  )
  expect_equal(
    sort(executed_test_files(third_run)),
    c("test-blip.R", "test-blop.R")
  )
})
