<!-- badges: start -->
[![Project Status: Concept – Minimal or no implementation has been done yet, or the repository is only intended to be a limited example, demo, or proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)
<!-- badges: end -->
Example workflow script:

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
      - uses: ropensci-review-tools/pkgcheck-action@v0
```