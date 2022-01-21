## Checks for [touchstone (v0.0.0.9002)](https://github.com/lorenzwalthert/touchstone)

git hash: [3c213df5](https://github.com/lorenzwalthert/touchstone/tree/3c213df5bb2c350603d821a934aab8716f439d87)

- :heavy_check_mark: Package name is available
- :heavy_multiplication_x: does not have a 'CITATION' file.
- :heavy_multiplication_x: does not have a 'codemeta.json' file.
- :heavy_multiplication_x: does not have a 'contributing' file.
- :heavy_check_mark: uses 'roxygen2'.
- :heavy_check_mark: 'DESCRIPTION' has a URL field.
- :heavy_check_mark: 'DESCRIPTION' has a BugReports field.
- :heavy_check_mark: Package has at least one HTML vignette
- :heavy_multiplication_x: These functions do not have examples: [benchmark_analyze, benchmark_ls, benchmark_read, benchmark_run, benchmark_write, branch_get_or_fail, branch_install, path_pinned_asset, pr_comment, touchstone_managers, touchstone_script, use_touchstone].
- :heavy_multiplication_x:  Package has no continuous integration checks.
- :heavy_check_mark: Package coverage is 86%.
- :heavy_check_mark: R CMD check found no errors.
- :heavy_check_mark: R CMD check found no warnings.

**Important:** All failing checks above must be addressed prior to proceeding

Package License: MIT + file LICENSE

---


### 1. Statistical Properties

This package features some noteworthy statistical properties which may need to be clarified by a handling editor prior to progressing.

<details>
<summary>Details of statistical properties (click to open)</summary>
<p>

The package has:

- code in R (100% in 10 files) and 
- 2 authors
- 2  vignettes
- no internal data file
- 12 imported packages
- 32 exported functions (median 10 lines of code)
- 89 non-exported functions in R (median 8 lines of code)

---

Statistical properties of package structure as distributional percentiles in relation to all current CRAN packages
The following terminology is used:
- `loc` = "Lines of Code"
- `fn` = "function"
- `exp`/`not_exp` = exported / not exported

The final measure (`fn_call_network_size`) is the total number of calls between functions (in R), or more abstract relationships between code objects in other languages. Values are flagged as "noteworthy" when they lie in the upper or lower 5th percentile.

|measure                  | value| percentile|noteworthy |
|:------------------------|-----:|----------:|:----------|
|files_R                  |    10|       59.0|           |
|files_vignettes          |     2|       85.7|           |
|files_tests              |     9|       89.6|           |
|loc_R                    |   846|       63.3|           |
|loc_vignettes            |   196|       48.7|           |
|loc_tests                |   521|       75.8|           |
|num_vignettes            |     2|       89.2|           |
|n_fns_r                  |   121|       80.9|           |
|n_fns_r_exported         |    32|       79.8|           |
|n_fns_r_not_exported     |    89|       81.5|           |
|n_fns_per_file_r         |     6|       75.7|           |
|num_params_per_fn        |     2|       11.9|           |
|loc_per_fn_r             |     8|       20.0|           |
|loc_per_fn_r_exp         |    10|       22.2|           |
|loc_per_fn_r_not_exp     |     8|       22.6|           |
|rel_whitespace_R         |    15|       59.3|           |
|rel_whitespace_vignettes |    33|       47.5|           |
|rel_whitespace_tests     |    12|       61.5|           |
|doclines_per_fn_exp      |    16|        7.0|           |
|doclines_per_fn_not_exp  |     0|        0.0|TRUE       |
|fn_call_network_size     |    98|       78.9|           |

---

</p></details>


### 1a. Network visualisation

Click to see the [interactive network visualisation of calls between objects in package](/media/jwj/cache/.cache/pkgcheck/static/touchstone_pkgstats3c213df5.html)

---

### 2. `goodpractice` and other checks

<details>
<summary>Details of goodpractice and other checks (click to open)</summary>
<p>



---


#### 3b. `goodpractice` results


#### `R CMD check` with [rcmdcheck](https://r-lib.github.io/rcmdcheck/)

rcmdcheck found no errors, warnings, or notes

#### Test coverage with [covr](https://covr.r-lib.org/)

Package coverage: 86.03

#### Cyclocomplexity with [cyclocomp](https://github.com/MangoTheCat/cyclocomp)

No functions have cyclocomplexity >= 15

#### Static code analyses with [lintr](https://github.com/jimhester/lintr)

[lintr](https://github.com/jimhester/lintr) found the following 48 potential issues:

message | number of times
--- | ---
Lines should not be more than 80 characters. | 48



</p>
</details>

---

<details>
<summary>Package Versions</summary>
<p>

|package  |version   |
|:--------|:---------|
|pkgstats |0.0.3.84  |
|pkgcheck |0.0.2.205 |

</p>
</details>
