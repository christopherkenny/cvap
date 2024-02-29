# cvap 0.1.5
* Adds support for 2022 CVAP estimates. Default year updated to 2022.

# cvap 0.1.4
* Resolves a testing error on CRAN

# cvap 0.1.3
* Adds support for 2021 CVAP estimates. Default year updated to 2021.
* Adds a new option to include the "implied" total of the `cvap` columns in `cvap_distribute()` and `cvap_distribute_censable()`. It is named `impl_cvap` and resolves (#2).

# cvap 0.1.2
* Adds support for `cvap_distribute()` to distribute by 'vap'. Default remains 'pop'.

# cvap 0.1.0
* Adds support for 2020 CVAP estimates
* Improves `cvap_distribute()` to avoid population loss, following the `geomander::estimate_down()` approach.
* Adds `clean` argument to `cvap_distribute_censable()`

# cvap 0.0.3

* Added a `NEWS.md` file to track changes to the package.
* Fix logo link redirect
