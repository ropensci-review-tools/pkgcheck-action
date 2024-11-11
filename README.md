# {pkgcheck} Github Action
<!-- badges: start -->
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Build & Push Docker](https://github.com/ropensci-review-tools/pkgcheck-action/actions/workflows/publish.yaml/badge.svg)](https://github.com/ropensci-review-tools/pkgcheck-action/actions/workflows/publish.yaml)
<!-- badges: end -->

This package contains a Github Actions script to automatically check R packages with [rOpenSci's {pkgcheck} system](https://docs.ropensci.org/pkgcheck/) which is run on all packages submitted for peer review.
This action will implement a GitHub Action to ensure your package is ready  to submit to [rOpenSci](https://ropensci.org/)'s peer review system. 
The results are shown in the workflow output, and can also be posted in a new or updated GitHub Issue.

## Usage

Like the GitHub actions functions from [the `usethis` package](https://usethis.r-lib.org/reference/index.html#git-and-github), the [`pkgcheck::use_github_action_pkcheck()` function](https://docs.ropensci.org/pkgcheck/reference/use_github_action_pkgcheck.html) will create a workflow file called `pkgcheck.yaml` in your local `.github/workflows` directory.
The default workflow has the following relatively simple structure:

```yaml
name: pkgcheck

# This will cancel running jobs once a new run is triggered
concurrency:
  group: ${{ github.workflow }}-${{ github.head_ref }}
  cancel-in-progress: true

on:
  # Manually trigger the Action under Actions/pkgcheck
  workflow_dispatch:
  # Run on every push to main
  push:
    branches:
      - main

jobs:
  pkgcheck:
    runs-on: ubuntu-latest
    permissions:
      issues: write
    steps:
      - uses: ropensci-review-tools/pkgcheck-action@main
```

Since Github changed the permissions model for CI actions, to have the `pkgcheck-action` open an issue, elevated permissions need to be granted by altering the [permissions of the job](https://docs.github.com/en/actions/security-guides/automatic-token-authentication):

```yaml
jobs:
  pkgcheck:
    runs-on: ubuntu-latest
    permissions:
      issues: write
    steps:
      - uses: ropensci-review-tools/pkgcheck-action@main
```

There are also several parameters which can be used to modify the workflow, as described in the following section.

### Environment variables

This action runs with one environment variable of `CI = "ropensci"`. This
enables
[`testthat::skip_on_ci()`](https://testthat.r-lib.org/reference/skip.html),
which skips tests if a variable named "CI" is set, regardless of value.
Alternately, tests can be fine-tuned to skip within `pkgcheck` by setting
`testthat::skip_if(Sys.getenv("CI") == "ropensci")`.

### Workflow parameters

The [`yaml` workflow
file](https://github.com/ropensci-review-tools/pkgcheck-action/blob/main/action.yaml)
which defines this action includes the following list of inputs:

```yaml
inputs:
  ref:
    description: "The ref to checkout and check. Set to empty string to skip checkout."
    default: "${{ github.ref }}"
    required: true
  post-to-issue:
    description: "Should the pkgcheck results be posted as an issue?"
    # If you use the 'pull_request' trigger and the PR is from outside the repo
    # (e.g. a fork), the job will fail due to permission issues
    # if this is set to 'true'. The default will prevent this.
    default: ${{ github.event_name != 'pull_request' }}
    required: true
  issue-title:
    description: "Name for the issue containing the pkgcheck results. Will be created or updated."
    # This will create a new issue for every branch, set it to something fixed 
    # to only create one issue that is updated via edits. 
    default: "pkgcheck results - ${{ github.ref_name }}"
    required: true
  summary-only:
    description: "Only post the check summary to issue. Set to false to get the full results in the issue."
    default: true
    required: true
  append-to-issue:
    description: "Should issue results be appended to existing issue, or posted in new issues."
    default: true
    required: true
```

The easiest way to customise these inputs is with [the `pkgcheck::use_github_action_pkgcheck()` function](https://docs.ropensci.org/pkgcheck/reference/use_github_action_pkgcheck.html) in R, the documentation of which includes the following example:

``` r
use_github_action_pkgcheck (inputs = list (`post-to-issue` = "false"))
```

That will produce a `.github/workflows/pkgcheck.yaml` file (or will update an existing file by setting the additional parameter, `overwrite = TRUE`) with the `job:` section changed from the default version shown above of:

```yaml
jobs: 
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: ropensci-review-tools/pkgcheck-action@main
```

to the modified version of:

```yaml
jobs: 
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: ropensci-review-tools/pkgcheck-action@main
        with:
          summary-only: false
```

That demonstrates that setting any of these parameters to non-default values by passing them as named list items to `pkgcheck::use_github_action_pkgcheck()` appends additional `yaml` lines to the workflow file through the `with:` statement.
Workflows can thus be controlled either from R as shown above, or by directly editing the workflow file using `with:` statements.
In R:

- Parameters must be passed as named items of a list named "inputs"
- Parameter names containing dashes must be specified within backticks.
- Parameter values must be specified in quotation marks.

In yaml scripts, parameter names and values should be specified exactly "as is", without quotation marks or backticks.

### Posting {pgkcheck} results to a GitHub issue in your repository

The default workflow file posts the {pkgcheck} results to an issue in the repository in which it was run. This requires the workflow to have write access to your repo, which is automatically the case for events triggered within your repository such as pushes and pull requests from collaborators with write access.

If a pull request is opened from outside the repository such as from a fork, the default `github.token` will not have write access, and so will not be able to put results in an issue.
This default behaviour protects your repository from malicious use of `pull_request` triggers.

:warning::warning: ***Never use the `pull_request_target` trigger as this will allow forks to run arbitrary code with access to your repos secrets***:warning::warning: For more information see [here](https://securitylab.github.com/research/github-actions-preventing-pwn-requests/).

The first time this action is run, {pkgcheck} results will be created in a new issue of your repository. By default, each subsequent run will then append results to the same issue. The issue may be closed at any time, and results will still appear.

## Versions

This action has no version tags, as you will always want to pass the newest {pgkcheck} available.

## Contributors


<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->

All contributions to this project are gratefully acknowledged using the [`allcontributors` package](https://github.com/ropenscilabs/allcontributors) following the [all-contributors](https://allcontributors.org) specification. Contributions of any kind are welcome!

<table>

<tr>
<td align="center">
<a href="https://github.com/assignUser">
<img src="https://avatars.githubusercontent.com/u/16141871?v=4" width="100px;" alt=""/>
</a><br>
<a href="https://github.com/ropensci-review-tools/pkgcheck-action/commits?author=assignUser">assignUser</a>
</td>
<td align="center">
<a href="https://github.com/mpadge">
<img src="https://avatars.githubusercontent.com/u/6697851?v=4" width="100px;" alt=""/>
</a><br>
<a href="https://github.com/ropensci-review-tools/pkgcheck-action/commits?author=mpadge">mpadge</a>
</td>
</tr>

</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

