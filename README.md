<!-- README.md is generated from README.Rmd. Please edit that file -->

# lazytest

<!-- badges: start -->

[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental) [![CRAN status](https://www.r-pkg.org/badges/version/lazytest)](https://CRAN.R-project.org/package=lazytest)

<!-- badges: end -->

The goal of lazytest is to save development time by helping you rerun only the tests that have failed during the last run. It integrates tightly with the testthat package and provides the `lazytest_local()` function, a drop-in replacement for [`testthat::test_local()`](https://testthat.r-lib.org/reference/test_package.html), that memoizes the tests that have failed and runs only those tests in subsequent runs. Once all remaining tests have succeeded, the remaining tests are run in a second pass.

## How does it work?

[`testthat::test_local()`](https://testthat.r-lib.org/reference/test_package.html) returns an object from which the tests that have failed can be retrieved. `lazytest_local()` wraps this function. If tests have failed, a file named `.lazytest` is written in the package directory. In the next call, if `.lazytest` exists, it is consulted, and a suitable `filter` argument is constructed and passed to [`testthat::test_local()`](https://testthat.r-lib.org/reference/test_package.html).

When all tests have passed and not all tests were run, a second call to [`testthat::test_local()`](https://testthat.r-lib.org/reference/test_package.html) is initiated, to make sure that no failures have been introduced in the meantime.

## Installation

You can install the development version of lazytest like so:

<pre class='chroma'>
<span><span class='nf'>pak</span><span class='nf'>::</span><span class='nf'><a href='http://pak.r-lib.org/reference/pak.html'>pak</a></span><span class='o'>(</span><span class='s'>"krlmlr/lazytest"</span><span class='o'>)</span></span></pre>

If you’re using RStudio, it is a good idea to remap the shortcut for running tests (default: Ctrl + Shift + T / Cmd + Shift + T). The add-in provides two commands:

- Run Lazy Tests in New Terminal (recommended mapping: Ctrl + Shift + T / Cmd + Shift + T)

- Reset And Run Lazy Tests in New Terminal (recommended mapping: Ctrl + T / Cmd + T)

This allows you to keep the workflows you’re accustomed to and to benefit immediately.

![RStudio shortcut configuration](https://github.com/krlmlr/lazytest/raw/main/readme/rstudio-kb.png)

------------------------------------------------------------------------

## Code of Conduct

Please note that the lazytest project is released with a [Contributor Code of Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.
