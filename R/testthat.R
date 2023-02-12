# From testthat, MIT licensed, https://testthat.r-lib.org/LICENSE.html

find_parallel <- function(path, load_package = "source", package = NULL) {
  # If env var is set, then use that
  parenv <- Sys.getenv("TESTTHAT_PARALLEL", NA_character_)
  if (!is.na(parenv)) {
    if (toupper(parenv) == "TRUE") return(TRUE)
    if (toupper(parenv) == "FALSE") return(FALSE)
    abort("`TESTTHAT_PARALLEL` must be `TRUE` or `FALSE`")
  }

  # Make sure we get the local package package if not "installed"
  if (load_package != "installed") package <- NULL
  desc <- find_description(path, package)
  if (is.null(desc)) {
    return(FALSE)
  }

  par <- identical(
    toupper(desc$get_field("Config/testthat/parallel", default = "FALSE")),
    "TRUE"
  )

  if (par) {
    ed <- as.integer(desc$get_field("Config/testthat/edition", default = 2L))
    if (ed < 3) {
      inform("Running tests in parallel requires the 3rd edition")
      par <- FALSE
    }
  }

  par
}

find_description <- function(path, package = NULL) {
  if (!is.null(package)) {
    return(desc::desc(package = package))
  } else {
    tryCatch(
      pkgload::pkg_desc(path),
      error = function(e) NULL
    )
  }
}

#' Find reporter object given name or object.
#'
#' If not found, will return informative error message.
#' Pass a character vector to create a [MultiReporter] composed
#' of individual reporters.
#' Will return null if given NULL.
#'
#' @param reporter name of reporter(s), or reporter object(s)
#' @noRd
#' @keywords internal
find_reporter_list <- function(reporter) {
  if (is.null(reporter)) return(NULL)

  if (inherits(reporter, "R6ClassGenerator")) {
    list(reporter$new())
  } else if (inherits(reporter, "Reporter")) {
    list(reporter)
  } else if (is.character(reporter)) {
    if (length(reporter) <= 1L) {
      list(find_reporter_one(reporter))
    } else {
      lapply(reporter, find_reporter_one)
    }
  } else {
    stop("Invalid input", call. = FALSE)
  }
}

find_reporter_one <- function(reporter, ...) {
  stopifnot(is.character(reporter))

  name <- reporter
  substr(name, 1, 1) <- toupper(substr(name, 1, 1))
  name <- paste0(name, "Reporter")

  if (!exists(name)) {
    stop("Can not find test reporter ", reporter, call. = FALSE)
  }

  get(name)$new(...)
}

test_files_check_df <- function(df, stop_on_failure = TRUE, stop_on_warning = FALSE) {
  if (stop_on_failure && !all_passed_df(df)) {
    stop("Test failures", call. = FALSE)
  }
  if (stop_on_warning && any_warnings_df(df)) {
    stop("Tests generated warnings", call. = FALSE)
  }

  invisible(df)
}

# return if all tests are successful w/o error
all_passed_df <- function(df) {
  sum(df$failed) == 0 && all(!df$error)
}

any_warnings_df <- function(df) {
  any(df$warning > 0)
}

as.data.frame.testthat_results <- function(x, ...) {
  if (length(x) == 0) {
    return(
      data.frame(
        file = character(0), context = character(0), test = character(0),
        nb = integer(0), failed = integer(0), skipped = logical(0),
        error = logical(0), warning = integer(0),
        user = numeric(0), system = numeric(0), real = numeric(0),
        passed = integer(0), result = list(),
        stringsAsFactors = FALSE
      )
    )
  }

  rows <- lapply(x, summarize_one_test_results)
  do.call(rbind, rows)
}

summarize_one_test_results <- function(test) {
  test_results <- test$results
  nb_tests <- length(test_results)

  nb_failed <- nb_skipped <- nb_warning <- nb_passed <- 0L
  error <- FALSE

  if (nb_tests > 0) {
    # error reports should be handled differently.
    # They may not correspond to an expect_that() test so remove them
    last_test <- test_results[[nb_tests]]
    error <- expectation_error(last_test)
    if (error) {
      test_results <- test_results[-nb_tests]
      nb_tests <- length(test_results)
    }

    nb_passed <- sum(vapply(test_results, expectation_success, logical(1)))
    nb_skipped <- sum(vapply(test_results, expectation_skip, logical(1)))
    nb_failed <- sum(vapply(test_results, expectation_failure, logical(1)))
    nb_warning <- sum(vapply(test_results, expectation_warning, logical(1)))
  }

  context <- if (length(test$context) > 0) test$context else ""

  res <- data.frame(
    file = test$file, context = context, test = test$test,
    nb = nb_tests, failed = nb_failed, skipped = as.logical(nb_skipped),
    error = error, warning = nb_warning,
    user = test$user, system = test$system, real = test$real,
    stringsAsFactors = FALSE
  )

  # Added at end for backward compatibility
  res$passed <- nb_passed

  # Cannot easily add list columns in data.frame()
  res$result <- list(test_results)
  res
}

context_name <- function(filename) {
  # Remove test- prefix
  filename <- sub("^test[-_]", "", filename)
  # Remove terminal extension
  filename <- sub("[.][Rr]$", "", filename)
  filename
}

expectation_type <- function(exp) {
  stopifnot(is.expectation(exp))
  gsub("^expectation_", "", class(exp)[[1]])
}

expectation_success <- function(exp) expectation_type(exp) == "success"
expectation_failure <- function(exp) expectation_type(exp) == "failure"
expectation_error   <- function(exp) expectation_type(exp) == "error"
expectation_skip    <- function(exp) expectation_type(exp) == "skip"
expectation_warning <- function(exp) expectation_type(exp) == "warning"
expectation_broken  <- function(exp) expectation_failure(exp) || expectation_error(exp)
expectation_ok      <- function(exp) expectation_type(exp) %in% c("success", "warning")
