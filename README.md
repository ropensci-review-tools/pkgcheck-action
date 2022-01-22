# {pkgcheck} Github Action
<!-- badges: start -->
[![Project Status: Concept – Minimal or no implementation has been done yet, or the repository is only intended to be a limited example, demo, or proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)
[![Build & Push Docker](https://github.com/ropensci-review-tools/pkgcheck-action/actions/workflows/publish.yaml/badge.svg)](https://github.com/ropensci-review-tools/pkgcheck-action/actions/workflows/publish.yaml)
<!-- badges: end -->

Use Github Actions to check your R package with [{pkgcheck}](https://docs.ropensci.org/pkgcheck/) and make sure it is ready to submit to [rOpenSci](https://ropensci.org/)'s peer review system. 
The results will be posted in a new or updated Issue and uploaded as workflow artifacts.

## Usage
You can either use `pkgcheck::use_github_check()` within your package repository or copy the basic workflow file below into `.github/workflows/pkgcheck.yaml`.

### Workflow triggers
If you want the results to be posted as an issue the workflow will need write access to your repo. This is automatically the case for events triggered within your repo like pushes and PRs from collaborators with write access.

If a PR is opened from outside the repo e.g. a fork, the default `github.token` will not have write access to protect your repository from malicious actors, if you use the `pull_request` trigger. The default setting for the `post-to-issue` trigger is set to prevent failure in case of pr

:warning::warning: ***Never use the `pull_request_target` trigger as this will allow forks to run arbitrary code with access to your repos secrets***:warning::warning: For more information see [here](https://securitylab.github.com/research/github-actions-preventing-pwn-requests/).

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
    branch: main

jobs: 
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: ropensci-review-tools/pkgcheck-action@main
```
### Inputs
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
    # to only create one issue.
    default: "pkgcheck results - ${{ github.ref_name }}"
    required: true
  summary-only:
    description: "Only post the check summary to issue. Set to false to get the full results in the issue."
    default: true
    required: true
```
## Versions
This action has no version tags, as you will always want to pass the newest {pgkcheck} available.

## Advanced Usage

If you want to customize your workflow in a way not possible with the inputs provided, you can use the container supplied by this repository as a base for a custom workflow.

A simple example using the `check.R` file from this repository:
```yaml
name: pkgcheck

concurrency:
  group: ${{ github.workflow }}-${{ github.head_ref }}
  cancel-in-progress: true

on: 
  # Manual trigger
  workflow_dispatch:
  # Run on every push to main
  push:
    branches:
      - main
  # Run on every PR to main
  pull_request:
    branches:
      - main

jobs:
  check:
    runs-on: ubuntu-latest
    container: ghcr.io/ropensci-review-tools/pkgcheck-action:latest
    env: 
      GITHUB_PAT: ${{ github.token }}
    steps:
      - uses: actions/checkout@v2
      - name: Run pkgcheck
        id: pkgcheck
        run: source("check.R")  # adjust path to script here
        shell: Rscript {0}
      - uses: actions/upload-artifact@v2
        with:
          name: visual-network
          path: "${{ steps.pkgcheck.outputs.visnet_path }}"
      - uses: actions/upload-artifact@v2
        with:
          name: results
          path: "${{ steps.pkgcheck.outputs.results }}"

```
