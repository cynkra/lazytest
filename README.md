
# lazytest

<!-- badges: start -->
[![CRAN status](https://www.r-pkg.org/badges/version/lazytest)](https://CRAN.R-project.org/package=lazytest)
<!-- badges: end -->

The goal of lazytest is to save development time by helping you rerun only the tests that have failed during the last run.
It integrates tightly with the testthat package and provides the `lazytest_local()` function, a drop-in replacement for `testthat::test_local()`, that memoizes the tests that have failed and runs only those tests in subsequent runs.
Once all remaining tests have succeeded, the remaining tests are run in a second pass.


## How does it work?

The testthat package exports a "reporter" interface that allows hooking into how tests are processed.
This package makes use of this interface and 


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

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(lazytest)
## basic example code
```

