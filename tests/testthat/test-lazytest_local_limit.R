test_that("lazytest_local() works", {
  skip_on_covr()
  skip_if_not_installed("here")
  skip_if_not_installed("usethis")
  withr::local_options(usethis.quiet = TRUE)

  # set up test package ----
  pkg_parent_dir <- withr::local_tempdir()
  pkg_dir <- file.path(pkg_parent_dir, "tea")
  usethis::create_package(pkg_dir)
  usethis::with_project(path = pkg_dir, {
    usethis::use_testthat(parallel = FALSE)
    usethis::use_test("blop", open = FALSE)
    usethis::use_test("blip", open = FALSE)
  })
  edit_test("blop", passing_test_lines(), pkg_dir = pkg_dir)
  edit_test("blip", failing_test_lines(20), pkg_dir = pkg_dir)

  # run tests, including one failing test, twice ----
  first_run <- run_lazytest(pkg_dir = pkg_dir, lazytest_dir = lazytest_dir())

  expect_true(file.exists(file.path(pkg_dir, ".lazytest")))
  # expect_snapshot_file didn't record anything?!
  expect_equal(
    brio::read_lines(file.path(pkg_dir, ".lazytest")),
    c("blip", "blop")
  )
  expect_equal(
    executed_test_files(first_run),
    c("test-blip.R")
  )

  second_run <- run_lazytest(pkg_dir = pkg_dir, lazytest_dir = lazytest_dir())
  expect_equal(
    executed_test_files(second_run),
    c("test-blip.R")
  )

  # fix failing test, run tests twice ----
  edit_test("blip", passing_test_lines(), pkg_dir = pkg_dir)
  new_run <- run_lazytest(pkg_dir = pkg_dir, lazytest_dir = lazytest_dir())
  # When all failing tests have succeeded, the entire test suite is rerun.
  expect_equal(
    executed_test_files(new_run),
    c("test-blip.R", "test-blop.R")
  )
  expect_false(file.exists(file.path(pkg_dir, ".lazytest")))

  run_lazytest(pkg_dir = pkg_dir, lazytest_dir = lazytest_dir())
  expect_match(
    toString(brio::read_lines(file.path(pkg_dir, "lazytest-msg"))),
    "Testing all tests next time"
    )

  last_run <- run_lazytest(pkg_dir = pkg_dir, lazytest_dir = lazytest_dir())
  expect_false(file.exists(file.path(pkg_dir, ".lazytest")))
  expect_equal(
    executed_test_files(last_run),
    c("test-blip.R", "test-blop.R")
  )
})
