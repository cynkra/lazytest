# Changelog

## lazytest 0.0.0.9073 (2025-10-26)

### Features

- Ignore test files without checks if all tests were successful.

- Stash away context before removing it.

- Don’t retry empty tests if all others are successful.

### Chore

- Auto-update from GitHub Actions.

  Run: <https://github.com/cynkra/lazytest/actions/runs/18800716937>

- Add explicit S3 method.

- Document.

- Format with air.

- Auto-update from GitHub Actions.

  Run: <https://github.com/cynkra/lazytest/actions/runs/17450846109>

- Auto-update from GitHub Actions.

  Run: <https://github.com/cynkra/lazytest/actions/runs/14636208510>

### Continuous integration

- Use reviewdog for external PRs
  ([\#62](https://github.com/cynkra/lazytest/issues/62)).

- Cleanup and fix macOS
  ([\#61](https://github.com/cynkra/lazytest/issues/61)).

- Format with air, check detritus, better handling of `extra-packages`
  ([\#60](https://github.com/cynkra/lazytest/issues/60)).

- Enhance permissions for workflow
  ([\#59](https://github.com/cynkra/lazytest/issues/59)).

- Permissions, better tests for missing suggests, lints
  ([\#58](https://github.com/cynkra/lazytest/issues/58)).

- Only fail covr builds if token is given
  ([\#57](https://github.com/cynkra/lazytest/issues/57)).

- Always use `_R_CHECK_FORCE_SUGGESTS_=false`
  ([\#56](https://github.com/cynkra/lazytest/issues/56)).

- Correct installation of xml2
  ([\#55](https://github.com/cynkra/lazytest/issues/55)).

- Explain ([\#54](https://github.com/cynkra/lazytest/issues/54)).

- Add xml2 for covr, print testthat results
  ([\#53](https://github.com/cynkra/lazytest/issues/53)).

- Fix ([\#52](https://github.com/cynkra/lazytest/issues/52)).

- Sync ([\#51](https://github.com/cynkra/lazytest/issues/51)).

### Testing

- Strengthen parallel test.

- Fix test.

## lazytest 0.0.0.9072 (2024-12-09)

### Continuous integration

- Avoid failure in fledge workflow if no changes
  ([\#49](https://github.com/cynkra/lazytest/issues/49)).

## lazytest 0.0.0.9071 (2024-12-08)

### Continuous integration

- Fetch tags for fledge workflow to avoid unnecessary NEWS entries
  ([\#48](https://github.com/cynkra/lazytest/issues/48)).

## lazytest 0.0.0.9070 (2024-12-07)

### Continuous integration

- Use larger retry count for lock-threads workflow
  ([\#47](https://github.com/cynkra/lazytest/issues/47)).

## lazytest 0.0.0.9069 (2024-11-28)

### Continuous integration

- Ignore errors when removing pkg-config on macOS
  ([\#46](https://github.com/cynkra/lazytest/issues/46)).

## lazytest 0.0.0.9068 (2024-11-27)

### Continuous integration

- Explicit permissions
  ([\#45](https://github.com/cynkra/lazytest/issues/45)).

## lazytest 0.0.0.9067 (2024-11-26)

### Continuous integration

- Use styler from main branch
  ([\#44](https://github.com/cynkra/lazytest/issues/44)).

## lazytest 0.0.0.9066 (2024-11-25)

### Continuous integration

- Need to install R on Ubuntu 24.04
  ([\#43](https://github.com/cynkra/lazytest/issues/43)).

- Use Ubuntu 24.04 and styler PR
  ([\#41](https://github.com/cynkra/lazytest/issues/41)).

### Documentation

- Add an example to README ([@maelle](https://github.com/maelle),
  [\#7](https://github.com/cynkra/lazytest/issues/7),
  [\#16](https://github.com/cynkra/lazytest/issues/16)).

## lazytest 0.0.0.9065 (2024-11-22)

### Continuous integration

- Correctly detect branch protection
  ([\#40](https://github.com/cynkra/lazytest/issues/40)).

## lazytest 0.0.0.9064 (2024-11-18)

### Continuous integration

- Use stable pak ([\#39](https://github.com/cynkra/lazytest/issues/39)).

## lazytest 0.0.0.9063 (2024-11-11)

### Continuous integration

- Trigger run ([\#38](https://github.com/cynkra/lazytest/issues/38)).

  - ci: Trigger run

  - ci: Latest changes

## lazytest 0.0.0.9062 (2024-10-28)

### Continuous integration

- Trigger run ([\#37](https://github.com/cynkra/lazytest/issues/37)).

- Use pkgdown branch
  ([\#36](https://github.com/cynkra/lazytest/issues/36)).

## lazytest 0.0.0.9061 (2024-09-15)

### Continuous integration

- Install via R CMD INSTALL ., not pak
  ([\#35](https://github.com/cynkra/lazytest/issues/35)).

  - ci: Install via R CMD INSTALL ., not pak

  - ci: Bump version of upload-artifact action

## lazytest 0.0.0.9060 (2024-08-31)

### Chore

- Auto-update from GitHub Actions.

  Run: <https://github.com/cynkra/lazytest/actions/runs/10425483393>

- Auto-update from GitHub Actions.

  Run: <https://github.com/cynkra/lazytest/actions/runs/10200109676>

- Auto-update from GitHub Actions.

  Run: <https://github.com/cynkra/lazytest/actions/runs/9730685037>

- Auto-update from GitHub Actions.

  Run: <https://github.com/cynkra/lazytest/actions/runs/9727974094>

- Auto-update from GitHub Actions.

  Run: <https://github.com/cynkra/lazytest/actions/runs/9691614439>

### Continuous integration

- Install local package for pkgdown builds.

- Improve support for protected branches with fledge.

- Improve support for protected branches, without fledge.

- Sync with latest developments.

- Use v2 instead of master.

- Inline action.

- Use dev roxygen2 and decor.

- Fix on Windows, tweak lock workflow.

- Fix on Windows.

- Avoid checking bashisms on Windows.

- Better commit message.

- Bump versions, better default, consume custom matrix.

- Recent updates.

### Documentation

- Set BS version explicitly for now.

  <https://github.com/cynkra/cynkratemplate/issues/53>

## lazytest 0.0.0.9059 (2024-01-24)

- Internal changes only.

## lazytest 0.0.0.9058 (2024-01-15)

- Internal changes only.

## lazytest 0.0.0.9057 (2023-11-07)

### Bug fixes

- Fix parallel runs, regression introduced in
  [\#31](https://github.com/cynkra/lazytest/issues/31)
  ([\#32](https://github.com/cynkra/lazytest/issues/32)).

## lazytest 0.0.0.9056 (2023-11-07)

### Bug fixes

- Retry all tests that haven’t been run at all, e.g., due to a limit
  ([\#30](https://github.com/cynkra/lazytest/issues/30),
  [\#31](https://github.com/cynkra/lazytest/issues/31)).

### Chore

- Add Aviator configuration.

## lazytest 0.0.0.9055 (2023-10-31)

### Testing

- Skip on covr.

## lazytest 0.0.0.9054 (2023-10-24)

### deps

- Require testthat \>= 3.2.0.

## lazytest 0.0.0.9053 (2023-10-17)

- Internal changes only.

## lazytest 0.0.0.9052 (2023-10-12)

### Chore

- Check presence of suggested packages.

## lazytest 0.0.0.9051 (2023-10-11)

### Chore

- Use nice to run tests.

- Use correect R path.

## lazytest 0.0.0.9050 (2023-10-10)

- Internal changes only.

## lazytest 0.0.0.9049 (2023-10-09)

- Internal changes only.

## lazytest 0.0.0.9048 (2023-06-17)

- Internal changes only.

## lazytest 0.0.0.9047 (2023-06-15)

- Internal changes only.

## lazytest 0.0.0.9046 (2023-06-14)

- Internal changes only.

## lazytest 0.0.0.9045 (2023-06-13)

- Internal changes only.

## lazytest 0.0.0.9044 (2023-06-11)

- Internal changes only.

## lazytest 0.0.0.9043 (2023-06-10)

- Internal changes only.

## lazytest 0.0.0.9042 (2023-06-08)

- Internal changes only.

## lazytest 0.0.0.9041 (2023-06-06)

- Internal changes only.

## lazytest 0.0.0.9040 (2023-06-05)

- Internal changes only.

## lazytest 0.0.0.9039 (2023-06-03)

- Internal changes only.

## lazytest 0.0.0.9038 (2023-06-02)

- Internal changes only.

## lazytest 0.0.0.9037 (2023-06-01)

- Internal changes only.

## lazytest 0.0.0.9036 (2023-05-28)

- Internal changes only.

## lazytest 0.0.0.9035 (2023-05-27)

- Internal changes only.

## lazytest 0.0.0.9034 (2023-05-23)

- Internal changes only.

## lazytest 0.0.0.9033 (2023-05-22)

- Internal changes only.

## lazytest 0.0.0.9032 (2023-05-21)

- Internal changes only.

## lazytest 0.0.0.9031 (2023-05-20)

### Documentation

- Urlchecker’s feedback ([@maelle](https://github.com/maelle),
  [\#26](https://github.com/cynkra/lazytest/issues/26)).

- Reduce variability ([@maelle](https://github.com/maelle),
  [\#25](https://github.com/cynkra/lazytest/issues/25),
  [\#27](https://github.com/cynkra/lazytest/issues/27)).

## lazytest 0.0.0.9030 (2023-05-19)

- Internal changes only.

## lazytest 0.0.0.9029 (2023-05-18)

- Internal changes only.

## lazytest 0.0.0.9028 (2023-05-17)

- Internal changes only.

## lazytest 0.0.0.9027 (2023-05-16)

### Documentation

- Add .lazytest guidance ([@maelle](https://github.com/maelle),
  [\#12](https://github.com/cynkra/lazytest/issues/12),
  [\#23](https://github.com/cynkra/lazytest/issues/23)).

- Add workaround for not having to quote testthat
  ([@maelle](https://github.com/maelle),
  [\#21](https://github.com/cynkra/lazytest/issues/21)).

## lazytest 0.0.0.9026 (2023-05-15)

- Internal changes only.

## lazytest 0.0.0.9025 (2023-05-14)

- Internal changes only.

## lazytest 0.0.0.9024 (2023-05-13)

- Internal changes only.

## lazytest 0.0.0.9023 (2023-05-12)

- Internal changes only.

## lazytest 0.0.0.9022 (2023-05-11)

- Internal changes only.

## lazytest 0.0.0.9021 (2023-05-10)

- Internal changes only.

## lazytest 0.0.0.9020 (2023-05-09)

- Internal changes only.

## lazytest 0.0.0.9019 (2023-05-08)

- Internal changes only.

## lazytest 0.0.0.9018 (2023-05-07)

- Internal changes only.

## lazytest 0.0.0.9017 (2023-05-03)

- Internal changes only.

## lazytest 0.0.0.9016 (2023-05-02)

- Internal changes only.

## lazytest 0.0.0.9015 (2023-05-01)

- Internal changes only.

## lazytest 0.0.0.9014 (2023-04-30)

- Internal changes only.

## lazytest 0.0.0.9013 (2023-04-29)

- Internal changes only.

## lazytest 0.0.0.9012 (2023-04-26)

- Internal changes only.

## lazytest 0.0.0.9011 (2023-04-25)

- Internal changes only.

## lazytest 0.0.0.9010 (2023-04-21)

### Documentation

- Fix GitHub links
  ([\#22](https://github.com/cynkra/lazytest/issues/22)).

- Add return for the exported function
  ([\#19](https://github.com/cynkra/lazytest/issues/19)).

### Refactoring

- From goodpractice/lintr
  ([\#15](https://github.com/cynkra/lazytest/issues/15)).

## lazytest 0.0.0.9009 (2023-04-20)

- Internal changes only.

## lazytest 0.0.0.9008 (2023-04-19)

- Internal changes only.

## lazytest 0.0.0.9007 (2023-04-18)

### Documentation

- Clarify Title ([@maelle](https://github.com/maelle),
  [\#18](https://github.com/cynkra/lazytest/issues/18)).

- Add cynkra as cph and fnd ([@maelle](https://github.com/maelle),
  [\#20](https://github.com/cynkra/lazytest/issues/20)).

- Add an example to README ([@maelle](https://github.com/maelle),
  [\#7](https://github.com/cynkra/lazytest/issues/7),
  [\#16](https://github.com/cynkra/lazytest/issues/16)).

### Refactoring

- Rm commented code ([@maelle](https://github.com/maelle),
  [\#4](https://github.com/cynkra/lazytest/issues/4),
  [\#14](https://github.com/cynkra/lazytest/issues/14)).

## lazytest 0.0.0.9006 (2023-04-15)

### Documentation

- Minimal README tweaks
  ([\#8](https://github.com/cynkra/lazytest/issues/8)).

- Cynkratemplate::use_cynkra_pkgdown()
  ([\#6](https://github.com/cynkra/lazytest/issues/6)).

### tests

- Add test infra and one test ([@maelle](https://github.com/maelle),
  [\#9](https://github.com/cynkra/lazytest/issues/9)).

## lazytest 0.0.0.9005 (2023-03-24)

- Internal changes only.

## lazytest 0.0.0.9004 (2023-02-17)

- Internal changes only.

## lazytest 0.0.0.9003 (2023-02-15)

### Documentation

- Fix wording.

## lazytest 0.0.0.9002 (2023-02-13)

- Internal changes only.

## lazytest 0.0.0.9001 (2023-02-12)

- Initial version with
  [`lazytest_local()`](https://lazytest.cynkra.com/reference/lazytest_local.md).
