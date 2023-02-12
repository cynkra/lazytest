run_tests <- function() {
  rstudioapi::terminalExecute("R -q -e 'testthat::test_local()'")
}

run_lazytests <- function() {
  rstudioapi::terminalExecute("R -q -e 'happy::lazytest_local()'")
}

run_lazytests_reset <- function() {
  rstudioapi::terminalExecute("R -q -e 'happy::lazytest_local(lazytest_reset = TRUE)'")
}
