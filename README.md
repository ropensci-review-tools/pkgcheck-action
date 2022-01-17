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
    container: mpdage/pkgcheck
    steps:
      - uses: assignUser/pkgcheck-action@docker
        with:
          cache-version: 1
        
```