#' Test a local source package
#'
#' A drop-in replacement for `testthat::test_local()` that by default reruns
#' only the tests that failed last time.
#'
#' @inheritParams testthat::test_local
#' @inheritParams testthat::test_dir
#' @param filter Must be `NULL`.
#' @param lazytest_reset Set to `TRUE` to run all tests, regardless of what the
#'   last test results were.
#' @export
#' @section Example:
#'
#' ```{r child='man/rmd/lazytest_local.Rmd'}
#' ```
lazytest_local <- function(path = ".",
                           reporter = NULL,
                           ...,
                           lazytest_reset = FALSE,
                           stop_on_failure = TRUE,
                           stop_on_warning = FALSE,
                           filter = NULL,
                           load_package = "source") {

  # return(test_local(
  #   path,
  #   reporter,
  #   ...,
  #   stop_on_failure = FALSE,
  #   stop_on_warning = FALSE,
  #   filter = filter,
  #   load_package = load_package
  # ))

  if (!identical(path, ".")) {
    cli::cli_abort('{.code lazytest_local()} currently only works with {.code path = "."}.')
  }

  if (!is.null(filter)) {
    cli::cli_abort("{.code lazytest_local()} requires {.code filter = NULL}, use {.code testthat::test_local()} to pass a {.code filter} argument.")
  }

  CONTEXT_FILE_NAME <- ".lazytest"

  has_context <- fs::file_exists(CONTEXT_FILE_NAME)
  if (has_context) {
    contexts <- brio::read_lines(CONTEXT_FILE_NAME)
    fs::file_delete(CONTEXT_FILE_NAME)
  }

  if (!has_context || lazytest_reset) {
    contexts <- NULL
  }

  if (is.null(contexts)) {
    cli::cli_inform(c(
      "i" = "Testing all tests."
    ))
  } else {
    cli::cli_inform(c(
      "i" = "Testing only tests that failed last time: ",
      set_names(contexts, "*")
    ))

    filter <- rex::rex(
      start,
      or(contexts),
      end
    )
  }

  out <- testthat::test_local(
    path,
    reporter,
    ...,
    stop_on_failure = FALSE,
    stop_on_warning = FALSE,
    filter = filter,
    load_package = load_package
  )

  result_df <- as.data.frame.testthat_results(out)

  passed_idx <- result_df$failed == 0 & !result_df$error

  failed_files <- unique(result_df$file[!passed_idx])

  failed_contexts <- context_name(failed_files)

  if (length(failed_contexts) > 0) {
    brio::write_lines(failed_contexts, CONTEXT_FILE_NAME)
    if (identical(failed_contexts, contexts)) {
      cli::cli_inform(c(
        ">" = "Repeating the same tests next time."
      ))
    } else {
      cli::cli_inform(c(
        ">" = "Testing the following tests next time: ",
        set_names(failed_contexts, "*")
      ))
    }
  } else if (has_context) {
    cli::cli_inform(c(
      ">" = "Testing all tests now."
    ))

    return(lazytest_local(
      path,
      reporter,
      ...,
      stop_on_failure = FALSE,
      stop_on_warning = FALSE,
      filter = NULL,
      load_package = load_package
    ))
  } else {
    cli::cli_inform(c(
      ">" = "Testing all tests next time."
    ))
  }

  test_files_check_df(
    result_df,
    stop_on_failure = stop_on_failure,
    stop_on_warning = stop_on_warning
  )

  invisible(out)
}
