# Version 1.7.1

* A CRAN mirror is set for `rr install`.

# Version 1.7

* `rr rocco no-pages` will run `rr rocco` without attempting to push to `gh_pages`.

# Version 1.6.1

* Use `library(methods)` for rocco and roxygen documentation to handle S3 classes.

# Version 1.6
* Adds `rr check` to run R CMD CHECK via devtools.

# Version 1.5
* Adds an additional argument to rr test to test an individual file.
* Fix `rr test <arg>` to work to test a directory.

# Version 1.4

* Introduces `rr rocco` to compile your Rocco documentation.

# Version 1.3.1

* `rr send` no longer runs tests.  Instead, just documentation + commiting.

# Version 1.3

* `rr release` will automatically read the package version from the `DESCRIPTION` file and release.

# Version 1.2

* `rr create` will create a new package scaffold.

# Version 1.1

* `rv` now opens a vanilla R in addition to `rn`.
* `rr install` now will install a pacakge from either CRAN or GitHub, instead of loading the package.
* Started versioning.
