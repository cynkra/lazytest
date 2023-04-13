# convoluted way to run the tests
# without their results being reported for the calling test file
run_lazytest <- function(pkg_dir, lazytest_dir) {
  withr::with_dir(pkg_dir, {
    process <- callr::r_bg(
      function(lazytest_dir) {
        pkgload::load_all(lazytest_dir)
        testthat_results <- lazytest::lazytest_local(stop_on_failure = FALSE)
        return(testthat_results)
      },
      args = list(lazytest_dir = lazytest_dir)
    )
    process$wait()
  })
}
