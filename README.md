Example script:

```yaml
name: pkgcheck

concurrency:
  group: ${{ github.workflow }}-${{ github.head_ref }}
  cancel-in-progress: true

on: workflow_dispatch

jobs: 
  check:
    runs-on: ubuntu-latest
    container: mpadge/pkgcheck
    env:
      GITHUB_PAT: ${{ secrets.GITHUB_TOKEN }}
      #Not required but can speed up the action
      RSPM: 'https://packagemanager.rstudio.com/all/__linux__/focal/latest'
    steps:
      - uses: assignUser/pkgcheck-action@docker
        with:
          cache-version: 1
        
```