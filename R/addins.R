run_tests <- function() {
  rstudioapi::terminalExecute("R -q -e 'testthat::test_local()'")
}

run_lazytests <- function() {
  cmd <- paste0(
    "R -q -e '",
    # 'pkgload::load_all("~/git/R/lazytest"); ',
    "lazytest::lazytest_local()'"
  )
  rstudioapi::terminalExecute(cmd)
}

run_lazytests_reset <- function() {
  cmd <- paste0(
    "R -q -e '",
    # 'pkgload::load_all("~/git/R/lazytest"); ',
    "lazytest::lazytest_local(lazytest_reset = TRUE)'"
  )
  rstudioapi::terminalExecute(cmd)
}
