# Test a local source package

A drop-in replacement for
[`testthat::test_local()`](https://testthat.r-lib.org/reference/test_package.html)
that by default reruns only the tests that failed last time.

## Usage

``` r
lazytest_local(
  path = ".",
  reporter = NULL,
  ...,
  lazytest_reset = FALSE,
  stop_on_failure = TRUE,
  stop_on_warning = FALSE,
  filter = NULL,
  load_package = "source"
)
```

## Arguments

- path:

  Path to directory containing tests.

- reporter:

  Reporter to use to summarise output. Can be supplied as a string (e.g.
  "summary") or as an R6 object (e.g. `SummaryReporter$new()`).

  See [Reporter](https://testthat.r-lib.org/reference/Reporter.html) for
  more details and a list of built-in reporters.

- ...:

  Additional arguments passed to
  [`test_dir()`](https://testthat.r-lib.org/reference/test_dir.html)

- lazytest_reset:

  Set to `TRUE` to run all tests, regardless of what the last test
  results were.

- stop_on_failure:

  If `TRUE`, throw an error if any tests fail.

- stop_on_warning:

  If `TRUE`, throw an error if any tests generate warnings.

- filter:

  Must be `NULL`.

- load_package:

  Strategy to use for load package code:

  - "none", the default, doesn't load the package.

  - "installed", uses [`library()`](https://rdrr.io/r/base/library.html)
    to load an installed package.

  - "source", uses
    [`pkgload::load_all()`](https://pkgload.r-lib.org/reference/load_all.html)
    to a source package. To configure the arguments passed to
    `load_all()`, add this field in your DESCRIPTION file:

        Config/testthat/load-all: list(export_all = FALSE, helpers = FALSE)

## Value

A list (invisibly) containing data about the test results, like
[`testthat::test_local()`](https://testthat.r-lib.org/reference/test_package.html).

## Example

Let's create a package with two boilerplate tests.

    withr::local_seed(42)
    withr::local_options(usethis.quiet = TRUE)

    pkg_parent_dir <- withr::local_tempdir()
    pkg_dir <- file.path(pkg_parent_dir, "tea")
    usethis::create_package(pkg_dir)
    usethis::with_project(path = pkg_dir, {
      usethis::use_testthat()
      usethis::use_test("blop")
      usethis::use_test("blip")
    })

If we run the tests, they all pass.

    withr::with_dir(
      pkg_dir,
      lazytest::lazytest_local()
    )
    #> i Testing all tests.
    #> v | F W  S  OK | Context
    #>
    #> / |          0 | blip
    #> v |          1 | blip
    #>
    #> / |          0 | blop
    #> v |          1 | blop
    #>
    #> == Results =====================================================================
    #> [ FAIL 0 | WARN 0 | SKIP 0 | PASS 2 ]
    #> v All tests passed.
    #> > Testing all tests next time.

Now if we replace one of the tests with a failing test,

    brio::write_lines(
      text =  c(
        'test_that("blop() works", {',
        'expect_equal(2 * 2, 42)',
        '})'
      ),
      path = file.path(pkg_dir, "tests", "testthat", "test-blop.R")
    )

and then run the tests,

    withr::with_dir(
      pkg_dir,
      lazytest::lazytest_local()
    )
    #> i Testing all tests.
    #> v | F W  S  OK | Context
    #>
    #> / |          0 | blip
    #> v |          1 | blip
    #>
    #> / |          0 | blop
    #> - | 1        0 | blop
    #> x | 1        0 | blop
    #> --------------------------------------------------------------------------------
    #> Failure ('test-blop.R:2:1'): blop() works
    #> 2 * 2 (`actual`) not equal to 42 (`expected`).
    #>
    #>   `actual`:  4.0
    #> `expected`: 42.0
    #> --------------------------------------------------------------------------------
    #>
    #> == Results =====================================================================
    #> -- Failed tests ----------------------------------------------------------------
    #> Failure ('test-blop.R:2:1'): blop() works
    #> 2 * 2 (`actual`) not equal to 42 (`expected`).
    #>
    #>   `actual`:  4.0
    #> `expected`: 42.0
    #>
    #> [ FAIL 1 | WARN 0 | SKIP 0 | PASS 1 ]
    #> > Testing the following tests next time:
    #> * blop
    #> Error: Test failures

a file is created with the failing test name:

    brio::read_lines(file.path(pkg_dir, ".lazytest"))
    #> [1] "blop"

Next time we run the tests, only this test will be run, until it is
fixed at which point all tests are run again to check no failure has
been introduced elsewhere.

    withr::with_dir(
      pkg_dir,
      lazytest::lazytest_local()
    )
    #> i Testing only tests that failed last time:
    #> * blop
    #> v | F W  S  OK | Context
    #>
    #> / |          0 | blop
    #> x | 1        0 | blop
    #> --------------------------------------------------------------------------------
    #> Failure ('test-blop.R:2:1'): blop() works
    #> 2 * 2 (`actual`) not equal to 42 (`expected`).
    #>
    #>   `actual`:  4.0
    #> `expected`: 42.0
    #> --------------------------------------------------------------------------------
    #>
    #> == Results =====================================================================
    #> -- Failed tests ----------------------------------------------------------------
    #> Failure ('test-blop.R:2:1'): blop() works
    #> 2 * 2 (`actual`) not equal to 42 (`expected`).
    #>
    #>   `actual`:  4.0
    #> `expected`: 42.0
    #>
    #> [ FAIL 1 | WARN 0 | SKIP 0 | PASS 0 ]
    #> > Repeating the same tests next time.
    #> Error: Test failures
