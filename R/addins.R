run_tests <- function() {
  rscript <- paste0("'", file.path(R.home("bin"), "Rscript"), "' ")
  nice <- Sys.which("nice")
  if (nice != "") {
    nice <- paste0("'", nice, "' ")
  }
  cmd <- paste0(nice, rscript, "-e 'testthat::test_local()'")
  rstudioapi::terminalExecute(cmd)
}

run_lazytests <- function() {
  rscript <- paste0("'", file.path(R.home("bin"), "Rscript"), "' ")
  nice <- Sys.which("nice")
  if (nice != "") {
    nice <- paste0("'", nice, "' ")
  }
  cmd <- paste0(nice, rscript, "-e '", "lazytest::lazytest_local()'")
  rstudioapi::terminalExecute(cmd)
}

run_lazytests_reset <- function() {
  rscript <- paste0("'", file.path(R.home("bin"), "Rscript"), "' ")
  nice <- Sys.which("nice")
  if (nice != "") {
    nice <- paste0("'", nice, "' ")
  }
  cmd <- paste0(
    nice,
    rscript,
    "-e '",
    "lazytest::lazytest_local(lazytest_reset = TRUE)'"
  )
  rstudioapi::terminalExecute(cmd)
}
