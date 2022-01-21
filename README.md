# {pkgcheck} Github Action
<!-- badges: start -->
[![Project Status: Concept – Minimal or no implementation has been done yet, or the repository is only intended to be a limited example, demo, or proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)
<!-- badges: end -->

Use Github Actions to check your R package with [{pkgcheck}](https://docs.ropensci.org/pkgcheck/) and make sure it is ready to submit to [rOpenSci](https://ropensci.org/)'s peer review system. 
The results will be posted in a new or updated Issue and uploaded as workflow artifacts.

## Usage
You can either use `pkgcheck::use_github_check()` within your package repository or copy the basic workflow file below int `.github/workflows/pkgcheck.yaml`.

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
## Inputs
```yaml
inputs:
  ref:
    description: "The ref to checkout and check. Set to empty string to skip checkout."
    default: "${{ github.ref }}"
    required: true
  post-to-issue:
    description: "Should the pkgcheck results be posted as an issue?"
    default: true
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