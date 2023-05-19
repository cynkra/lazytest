<!-- README.md is generated from README.Rmd. Please edit that file -->

# lazytest

<!-- badges: start -->

[![R-CMD-check](https://github.com/cynkra/lazytest/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/cynkra/lazytest/actions/workflows/R-CMD-check.yaml) [![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental) [![CRAN status](https://www.r-pkg.org/badges/version/lazytest)](https://CRAN.R-project.org/package=lazytest)

<!-- badges: end -->

<pre class='chroma'>
<span><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://github.com/cynkra/lazytest'>lazytest</a></span><span class='o'>)</span></span></pre>

The goal of lazytest is to save development time by helping you rerun only the tests that have failed during the last run. It integrates tightly with the testthat package and provides the [`lazytest_local()`](https://lazytest.cynkra.com/reference/lazytest_local.html) function, a drop-in replacement for [`testthat::test_local()`](https://testthat.r-lib.org/reference/test_package.html), that

- memoizes which tests have failed;
- runs only those tests in subsequent runs.

If all active tests have succeeded, the entire test suite is run in a second pass.

## Usage

Call [`lazytest_local()`](https://lazytest.cynkra.com/reference/lazytest_local.html) instead of [`testthat::test_local()`](https://testthat.r-lib.org/reference/test_package.html) or [`devtools::test()`](https://devtools.r-lib.org/reference/test.html):

<pre class='chroma'>
<span><span class='nf'>lazytest</span><span class='nf'>::</span><span class='nf'><a href='https://lazytest.cynkra.com/reference/lazytest_local.html'>lazytest_local</a></span><span class='o'>(</span><span class='o'>)</span></span></pre>

The package also provides RStudio add-ins that run the tests in a new terminal. Unfortunately, the “Test package” command is hard-wired to [`devtools::test()`](https://devtools.r-lib.org/reference/test.html), and there seems to be no way to customize it or hook into it.

## Example

Let’s create a package with two boilerplate tests.

<pre class='chroma'>
<span><span class='nf'>withr</span><span class='nf'>::</span><span class='nf'><a href='https://withr.r-lib.org/reference/with_options.html'>local_options</a></span><span class='o'>(</span>usethis.quiet <span class='o'>=</span> <span class='kc'>TRUE</span><span class='o'>)</span></span>
<span></span>
<span><span class='nv'>pkg_parent_dir</span> <span class='o'>&lt;-</span> <span class='nf'>withr</span><span class='nf'>::</span><span class='nf'><a href='https://withr.r-lib.org/reference/with_tempfile.html'>local_tempdir</a></span><span class='o'>(</span><span class='o'>)</span></span>
<span><span class='nv'>pkg_dir</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/file.path.html'>file.path</a></span><span class='o'>(</span><span class='nv'>pkg_parent_dir</span>, <span class='s'>"tea"</span><span class='o'>)</span></span>
<span><span class='nf'>usethis</span><span class='nf'>::</span><span class='nf'><a href='https://usethis.r-lib.org/reference/create_package.html'>create_package</a></span><span class='o'>(</span><span class='nv'>pkg_dir</span><span class='o'>)</span></span>
<span><span class='nf'>usethis</span><span class='nf'>::</span><span class='nf'><a href='https://usethis.r-lib.org/reference/proj_utils.html'>with_project</a></span><span class='o'>(</span>path <span class='o'>=</span> <span class='nv'>pkg_dir</span>, <span class='o'>{</span></span>
<span>  <span class='nf'>usethis</span><span class='nf'>::</span><span class='nf'><a href='https://usethis.r-lib.org/reference/use_testthat.html'>use_testthat</a></span><span class='o'>(</span><span class='o'>)</span></span>
<span>  <span class='nf'>usethis</span><span class='nf'>::</span><span class='nf'><a href='https://usethis.r-lib.org/reference/use_r.html'>use_test</a></span><span class='o'>(</span><span class='s'>"blop"</span><span class='o'>)</span></span>
<span>  <span class='nf'>usethis</span><span class='nf'>::</span><span class='nf'><a href='https://usethis.r-lib.org/reference/use_r.html'>use_test</a></span><span class='o'>(</span><span class='s'>"blip"</span><span class='o'>)</span></span>
<span><span class='o'>}</span><span class='o'>)</span></span></pre>

If we run the tests, they all pass.

<pre class='chroma'>
<span><span class='nf'>withr</span><span class='nf'>::</span><span class='nf'><a href='https://withr.r-lib.org/reference/with_dir.html'>with_dir</a></span><span class='o'>(</span></span>
<span>  <span class='nv'>pkg_dir</span>,</span>
<span>  <span class='nf'>lazytest</span><span class='nf'>::</span><span class='nf'><a href='https://lazytest.cynkra.com/reference/lazytest_local.html'>lazytest_local</a></span><span class='o'>(</span><span class='o'>)</span></span>
<span><span class='o'>)</span></span>
<span><span class='c'>#&gt; <span style='color: #00BBBB;'>ℹ</span> Testing all tests.</span></span>
<span><span class='c'>#&gt; <span style='color: #00BB00;'>✔</span> | <span style='color: #BBBB00;'>F</span> <span style='color: #BB00BB;'>W</span> <span style='color: #0000BB;'>S</span> <span style='color: #00BB00;'> OK</span> | Context</span></span>
<span><span class='c'>#&gt; ⠏ |         0 | blip                                                            <span style='color: #00BB00;'>✔</span> |         1 | blip</span></span>
<span><span class='c'>#&gt; ⠏ |         0 | blop                                                            <span style='color: #00BB00;'>✔</span> |         1 | blop</span></span>
<span><span class='c'>#&gt; </span></span>
<span><span class='c'>#&gt; ══ <span style='font-weight: bold;'>Results</span> ═════════════════════════════════════════════════════════════════════</span></span>
<span><span class='c'>#&gt; [ FAIL 0 | WARN 0 | SKIP 0 | <span style='color: #00BB00;'>PASS</span> 2 ]</span></span>
<span><span class='c'>#&gt; → Testing all tests next time.</span></span></pre>

Now if we replace one of the tests with a failing test,

<pre class='chroma'>
<span><span class='nf'>brio</span><span class='nf'>::</span><span class='nf'><a href='https://brio.r-lib.org/reference/write_lines.html'>write_lines</a></span><span class='o'>(</span></span>
<span>  text <span class='o'>=</span>  <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span></span>
<span>    <span class='s'>'test_that("blop() works", {'</span>,</span>
<span>    <span class='s'>'expect_equal(2 * 2, 42)'</span>,</span>
<span>    <span class='s'>'})'</span></span>
<span>  <span class='o'>)</span>,</span>
<span>  path <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/file.path.html'>file.path</a></span><span class='o'>(</span><span class='nv'>pkg_dir</span>, <span class='s'>"tests"</span>, <span class='s'>"testthat"</span>, <span class='s'>"test-blop.R"</span><span class='o'>)</span></span>
<span><span class='o'>)</span></span></pre>

and then run the tests,

<pre class='chroma'>
<span><span class='nf'>withr</span><span class='nf'>::</span><span class='nf'><a href='https://withr.r-lib.org/reference/with_dir.html'>with_dir</a></span><span class='o'>(</span></span>
<span>  <span class='nv'>pkg_dir</span>,</span>
<span>  <span class='nf'>lazytest</span><span class='nf'>::</span><span class='nf'><a href='https://lazytest.cynkra.com/reference/lazytest_local.html'>lazytest_local</a></span><span class='o'>(</span><span class='o'>)</span></span>
<span><span class='o'>)</span></span>
<span><span class='c'>#&gt; <span style='color: #00BBBB;'>ℹ</span> Testing all tests.</span></span>
<span><span class='c'>#&gt; <span style='color: #00BB00;'>✔</span> | <span style='color: #BBBB00;'>F</span> <span style='color: #BB00BB;'>W</span> <span style='color: #0000BB;'>S</span> <span style='color: #00BB00;'> OK</span> | Context</span></span>
<span><span class='c'>#&gt; ⠏ |         0 | blip                                                            <span style='color: #00BB00;'>✔</span> |         1 | blip</span></span>
<span><span class='c'>#&gt; ⠏ |         0 | blop                                                            ⠋ | 1       0 | blop                                                            <span style='color: #BB0000;'>✖</span> | <span style='color: #BBBB00;'>1</span>       0 | blop<span style='color: #555555;'> [0.2s]</span></span></span>
<span><span class='c'>#&gt; ────────────────────────────────────────────────────────────────────────────────</span></span>
<span><span class='c'>#&gt; <span style='color: #BBBB00; font-weight: bold;'>Failure</span><span style='font-weight: bold;'> (</span><span style='color: #0000BB; font-weight: bold;'>test-blop.R:2:1</span><span style='font-weight: bold;'>): blop() works</span></span></span>
<span><span class='c'>#&gt; 2 * 2 (`actual`) not equal to 42 (`expected`).</span></span>
<span><span class='c'>#&gt; </span></span>
<span><span class='c'>#&gt;   `actual`:  <span style='color: #00BB00;'>4</span></span></span>
<span><span class='c'>#&gt; `expected`: <span style='color: #00BB00;'>42</span></span></span>
<span><span class='c'>#&gt; ────────────────────────────────────────────────────────────────────────────────</span></span>
<span><span class='c'>#&gt; </span></span>
<span><span class='c'>#&gt; ══ <span style='font-weight: bold;'>Results</span> ═════════════════════════════════════════════════════════════════════</span></span>
<span><span class='c'>#&gt; <span style='color: #00BBBB;'>Duration: 0.3 s</span></span></span>
<span><span class='c'>#&gt; </span></span>
<span><span class='c'>#&gt; [ <span style='color: #BBBB00;'>FAIL</span> 1 | WARN 0 | SKIP 0 | PASS 1 ]</span></span>
<span><span class='c'>#&gt; → Testing the following tests next time:</span></span>
<span><span class='c'>#&gt; <span style='color: #00BBBB;'>•</span> blop</span></span>
<span><span class='c'>#&gt; Error: Test failures</span></span></pre>

a file is created with the failing test name:

<pre class='chroma'>
<span><span class='nf'>brio</span><span class='nf'>::</span><span class='nf'><a href='https://brio.r-lib.org/reference/read_lines.html'>read_lines</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/file.path.html'>file.path</a></span><span class='o'>(</span><span class='nv'>pkg_dir</span>, <span class='s'>".lazytest"</span><span class='o'>)</span><span class='o'>)</span></span>
<span><span class='c'>#&gt; [1] "blop"</span></span></pre>

Next time we run the tests, only this test will be run, until it is fixed at which point all tests are run again to check no failure has been introduced elsewhere.

<pre class='chroma'>
<span><span class='nf'>withr</span><span class='nf'>::</span><span class='nf'><a href='https://withr.r-lib.org/reference/with_dir.html'>with_dir</a></span><span class='o'>(</span></span>
<span>  <span class='nv'>pkg_dir</span>,</span>
<span>  <span class='nf'>lazytest</span><span class='nf'>::</span><span class='nf'><a href='https://lazytest.cynkra.com/reference/lazytest_local.html'>lazytest_local</a></span><span class='o'>(</span><span class='o'>)</span></span>
<span><span class='o'>)</span></span>
<span><span class='c'>#&gt; <span style='color: #00BBBB;'>ℹ</span> Testing only tests that failed last time:</span></span>
<span><span class='c'>#&gt; <span style='color: #00BBBB;'>•</span> blop</span></span>
<span><span class='c'>#&gt; <span style='color: #00BB00;'>✔</span> | <span style='color: #BBBB00;'>F</span> <span style='color: #BB00BB;'>W</span> <span style='color: #0000BB;'>S</span> <span style='color: #00BB00;'> OK</span> | Context</span></span>
<span><span class='c'>#&gt; ⠏ |         0 | blop                                                            <span style='color: #BB0000;'>✖</span> | <span style='color: #BBBB00;'>1</span>       0 | blop</span></span>
<span><span class='c'>#&gt; ────────────────────────────────────────────────────────────────────────────────</span></span>
<span><span class='c'>#&gt; <span style='color: #BBBB00; font-weight: bold;'>Failure</span><span style='font-weight: bold;'> (</span><span style='color: #0000BB; font-weight: bold;'>test-blop.R:2:1</span><span style='font-weight: bold;'>): blop() works</span></span></span>
<span><span class='c'>#&gt; 2 * 2 (`actual`) not equal to 42 (`expected`).</span></span>
<span><span class='c'>#&gt; </span></span>
<span><span class='c'>#&gt;   `actual`:  <span style='color: #00BB00;'>4</span></span></span>
<span><span class='c'>#&gt; `expected`: <span style='color: #00BB00;'>42</span></span></span>
<span><span class='c'>#&gt; ────────────────────────────────────────────────────────────────────────────────</span></span>
<span><span class='c'>#&gt; </span></span>
<span><span class='c'>#&gt; ══ <span style='font-weight: bold;'>Results</span> ═════════════════════════════════════════════════════════════════════</span></span>
<span><span class='c'>#&gt; [ <span style='color: #BBBB00;'>FAIL</span> 1 | WARN 0 | SKIP 0 | PASS 0 ]</span></span>
<span><span class='c'>#&gt; → Repeating the same tests next time.</span></span>
<span><span class='c'>#&gt; Error: Test failures</span></span></pre>

## How does it work?

[`testthat::test_local()`](https://testthat.r-lib.org/reference/test_package.html) returns an object from which the tests that have failed can be retrieved. [`lazytest_local()`](https://lazytest.cynkra.com/reference/lazytest_local.html) wraps this function. If tests have failed, a file named `.lazytest` is written in the package directory. In the next call, if `.lazytest` exists, it is consulted, and a suitable `filter` argument is constructed and passed to [`testthat::test_local()`](https://testthat.r-lib.org/reference/test_package.html).

When all tests have passed and not all tests were run, a second call to [`testthat::test_local()`](https://testthat.r-lib.org/reference/test_package.html) is initiated, to make sure that no failures have been introduced in the meantime.

The presence of a `.lazytest` file in the package source indicates that the last test run has failed somewhere. You should not need to gitignore or Rbuildignore it: you should fix the reason behind the test failure, then run tests again, before committing to your repository’s default branch for instance.

## Installation and optional setup

You can install the development version of lazytest from [cynkra R-universe](https://cynkra.r-universe.dev/):

<pre class='chroma'>
<span><span class='nf'><a href='https://rdrr.io/r/utils/install.packages.html'>install.packages</a></span><span class='o'>(</span><span class='s'>'lazytest'</span>, repos <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>'https://cynkra.r-universe.dev'</span>, <span class='s'>'https://cloud.r-project.org'</span><span class='o'>)</span><span class='o'>)</span></span></pre>

Or from GitHub:

<pre class='chroma'>
<span><span class='nf'>pak</span><span class='nf'>::</span><span class='nf'><a href='https://pak.r-lib.org/reference/pak.html'>pak</a></span><span class='o'>(</span><span class='s'>"krlmlr/lazytest"</span><span class='o'>)</span></span></pre>

If you’re using RStudio, it is a good idea to remap the shortcut for running tests (default: Ctrl + Shift + T / Cmd + Shift + T). The add-in provides two commands:

- Run Lazy Tests in New Terminal (recommended mapping: Ctrl + Shift + T / Cmd + Shift + T)

- Reset And Run Lazy Tests in New Terminal (recommended mapping: Ctrl + T / Cmd + T)

This allows you to keep the workflows you’re accustomed to and to benefit immediately.

![RStudio shortcut configuration](https://github.com/cynkra/lazytest/raw/main/readme/rstudio-kb.png)

------------------------------------------------------------------------

## Code of Conduct

Please note that the lazytest project is released with a [Contributor Code of Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.
