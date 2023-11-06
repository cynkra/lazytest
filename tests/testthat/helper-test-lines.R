passing_test_lines <- function() {
  c(
    'test_that("blop() works", {',
    'expect_equal(2 * 2, 4)',
    '})'
  )
}

failing_test_lines <- function(n = 1) {
  c(
    'test_that("blop() works", {',
    rep('  expect_equal(2 * 2, 42)', n),
    '})'
  )
}

edit_test <- function(test_name, test_lines, pkg_dir) {
  brio::write_lines(
    test_lines,
    file.path(pkg_dir, "tests", "testthat", sprintf("test-%s.R", test_name))
  )
}
