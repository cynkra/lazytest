# lazytest

``` chroma
library(lazytest)
```

The goal of lazytest is to save development time by helping you rerun
only the tests that have failed during the last run. It integrates
tightly with the testthat package and provides the
[`lazytest_local()`](https://lazytest.cynkra.com/reference/lazytest_local.html)
function, a drop-in replacement for
[`testthat::test_local()`](https://testthat.r-lib.org/reference/test_package.html),
that

- memoizes which tests have failed;
- runs only those tests in subsequent runs.

If all active tests have succeeded, the entire test suite is run in a
second pass.

## Usage

Call
[`lazytest_local()`](https://lazytest.cynkra.com/reference/lazytest_local.html)
instead of
[`testthat::test_local()`](https://testthat.r-lib.org/reference/test_package.html)
or [`devtools::test()`](https://devtools.r-lib.org/reference/test.html):

``` chroma
lazytest::lazytest_local()
```

The package also provides RStudio add-ins that run the tests in a new
terminal. Unfortunately, the “Test package” command is hard-wired to
[`devtools::test()`](https://devtools.r-lib.org/reference/test.html),
and there seems to be no way to customize it or hook into it.

## Example

Let’s create a package with two boilerplate tests.

``` chroma
withr::local_options(usethis.quiet = TRUE)

pkg_parent_dir <- withr::local_tempdir()
pkg_dir <- file.path(pkg_parent_dir, "tea")
usethis::create_package(pkg_dir)
usethis::with_project(path = pkg_dir, {
  usethis::use_testthat()
  usethis::use_test("blop")
  usethis::use_test("blip")
})
```

If we run the tests, they all pass.

``` chroma
withr::with_dir(
  pkg_dir,
  lazytest::lazytest_local()
)
#> ℹ Testing all tests.
#> ✔ | F W S  OK | Context
#> ⠏ |         0 | blip                                                            ✔ |         1 | blip
#> ⠏ |         0 | blop                                                            ✔ |         1 | blop
#> 
#> ══ Results ═════════════════════════════════════════════════════════════════════
#> [ FAIL 0 | WARN 0 | SKIP 0 | PASS 2 ]
#> → Testing all tests next time.
```

Now if we replace one of the tests with a failing test,

``` chroma
brio::write_lines(
  text =  c(
    'test_that("blop() works", {',
    'expect_equal(2 * 2, 42)',
    '})'
  ),
  path = file.path(pkg_dir, "tests", "testthat", "test-blop.R")
)
```

and then run the tests,

``` chroma
withr::with_dir(
  pkg_dir,
  lazytest::lazytest_local()
)
#> ℹ Testing all tests.
#> ✔ | F W S  OK | Context
#> ⠏ |         0 | blip                                                            ✔ |         1 | blip
#> ⠏ |         0 | blop                                                            ⠋ | 1       0 | blop                                                            ✖ | 1       0 | blop [0.2s]
#> ────────────────────────────────────────────────────────────────────────────────
#> Failure (test-blop.R:2:1): blop() works
#> 2 * 2 (`actual`) not equal to 42 (`expected`).
#> 
#>   `actual`:  4
#> `expected`: 42
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> ══ Results ═════════════════════════════════════════════════════════════════════
#> Duration: 0.3 s
#> 
#> [ FAIL 1 | WARN 0 | SKIP 0 | PASS 1 ]
#> → Testing the following tests next time:
#> • blop
#> Error: Test failures
```

a file is created with the failing test name:

``` chroma
brio::read_lines(file.path(pkg_dir, ".lazytest"))
#> [1] "blop"
```

Next time we run the tests, only this test will be run, until it is
fixed at which point all tests are run again to check no failure has
been introduced elsewhere.

``` chroma
withr::with_dir(
  pkg_dir,
  lazytest::lazytest_local()
)
#> ℹ Testing only tests that failed last time:
#> • blop
#> ✔ | F W S  OK | Context
#> ⠏ |         0 | blop                                                            ✖ | 1       0 | blop
#> ────────────────────────────────────────────────────────────────────────────────
#> Failure (test-blop.R:2:1): blop() works
#> 2 * 2 (`actual`) not equal to 42 (`expected`).
#> 
#>   `actual`:  4
#> `expected`: 42
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> ══ Results ═════════════════════════════════════════════════════════════════════
#> [ FAIL 1 | WARN 0 | SKIP 0 | PASS 0 ]
#> → Repeating the same tests next time.
#> Error: Test failures
```

## How does it work?

[`testthat::test_local()`](https://testthat.r-lib.org/reference/test_package.html)
returns an object from which the tests that have failed can be
retrieved.
[`lazytest_local()`](https://lazytest.cynkra.com/reference/lazytest_local.html)
wraps this function. If tests have failed, a file named `.lazytest` is
written in the package directory. In the next call, if `.lazytest`
exists, it is consulted, and a suitable `filter` argument is constructed
and passed to
[`testthat::test_local()`](https://testthat.r-lib.org/reference/test_package.html).

When all tests have passed and not all tests were run, a second call to
[`testthat::test_local()`](https://testthat.r-lib.org/reference/test_package.html)
is initiated, to make sure that no failures have been introduced in the
meantime.

The presence of a `.lazytest` file in the package source indicates that
the last test run has failed somewhere. You should not need to gitignore
or Rbuildignore it: you should fix the reason behind the test failure,
then run tests again, before committing to your repository’s default
branch for instance.

## Installation and optional setup

You can install the development version of lazytest from [cynkra
R-universe](https://cynkra.r-universe.dev/):

``` chroma
install.packages('lazytest', repos = c('https://cynkra.r-universe.dev', 'https://cloud.r-project.org'))
```

Or from GitHub:

``` chroma
pak::pak("krlmlr/lazytest")
```

If you’re using RStudio, it is a good idea to remap the shortcut for
running tests (default: Ctrl + Shift + T / Cmd + Shift + T). The add-in
provides two commands:

- Run Lazy Tests in New Terminal (recommended mapping: Ctrl + Shift + T
  / Cmd + Shift + T)

- Reset And Run Lazy Tests in New Terminal (recommended mapping: Ctrl +
  T / Cmd + T)

This allows you to keep the workflows you’re accustomed to and to
benefit immediately.

![RStudio shortcut
configuration](https://github.com/cynkra/lazytest/raw/main/readme/rstudio-kb.png)

RStudio shortcut configuration

------------------------------------------------------------------------

## Code of Conduct

Please note that the lazytest project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
