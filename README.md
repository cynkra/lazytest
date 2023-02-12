
# lazytest

<!-- badges: start -->
[![CRAN status](https://www.r-pkg.org/badges/version/lazytest)](https://CRAN.R-project.org/package=lazytest)
<!-- badges: end -->

The goal of lazytest is to save development time by helping you rerun only the tests that have failed during the last run.
It integrates tightly with the testthat package and provides the `lazytest_local()` function, a drop-in replacement for `testthat::test_local()`, that memoizes the tests that have failed and runs only those tests in subsequent runs.
Once all remaining tests have succeeded, the remaining tests are run in a second pass.


## How does it work?

`testthat::test_local()` returns an object from which the tests that have failed can be retrieved.
`lazytest_local()` wraps this function.
If tests have failed, a file named `.lazytest` is written in the package directory.
In the next call, if `.lazytest` exists, it is consulted, and a suitable `filter` argument is constructed and passed to `testthat::test_local()`.

When all tests have passed and not all tests were run, a second call to `testthat::test_local()` is initiated, to make sure that no failures have been introduced in the meantime.


## Installation

You can install the development version of lazytest like so:

``` r
pak::pak("krlmlr/lazytest")
```

If you're using RStudio, it is a good idea to remap the shortcut for running tests (default: Ctrl + Shift + T / Cmd + Shift + T).
The add-in provides two commands:

- Run Lazy Tests in New Terminal (recommended mapping: Ctrl + Shift + T / Cmd + Shift + T)

- Reset And Run Lazy Tests in New Terminal (recommended mapping: Ctrl + T / Cmd + T)

This allows you to keep the workflows you're accustomed to and to benefit immediately.

![RStudio shortcut configuration](https://github.com/krlmlr/lazytest/raw/main/readme/rstudio-kb.png)
