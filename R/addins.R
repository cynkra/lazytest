run_tests <- function() {
  rscript <- paste0("'", file.path(R.home("bin"), "Rscript"), "' ")
  cmd <- paste0(rscript, "-e 'testthat::test_local()'")
  rstudioapi::terminalExecute(cmd)
}

run_lazytests <- function() {
  rscript <- paste0("'", file.path(R.home("bin"), "Rscript"), "' ")
  cmd <- paste0(rscript, "-e '", "lazytest::lazytest_local()'")
  rstudioapi::terminalExecute(cmd)
}

run_lazytests_reset <- function() {
  rscript <- paste0("'", file.path(R.home("bin"), "Rscript"), "' ")
  cmd <- paste0(rscript, "-e '", "lazytest::lazytest_local(lazytest_reset = TRUE)'")
  rstudioapi::terminalExecute(cmd)
}
