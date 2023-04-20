# convoluted way to run the tests
# without their results being reported for the calling test file
run_lazytest <- function(pkg_dir, lazytest_dir) {
  process <- callr::r_bg(
    function(pkg_dir, lazytest_dir) {
      if (grepl("Rcheck", lazytest_dir)) {
        library("lazytest")
      } else {
        pkgload::load_all(lazytest_dir)
      }
      testthat_results <- lazytest_local(pkg_dir, stop_on_failure = FALSE)
      return(testthat_results)
    },
    args = list(pkg_dir = pkg_dir, lazytest_dir = lazytest_dir),
    stderr = file.path(pkg_dir, "lazytest-msg") # catching lazytest messages
  )
  process$wait()
}

lazytest_dir <- find.package("lazytest")
executed_test_files <- function(callr_output) {
  as.data.frame.testthat_results(callr_output$get_result())[,1]
}
