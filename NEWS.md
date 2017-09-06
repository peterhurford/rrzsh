# Version 1.16

* Amends `rr install` to use a working CRAN mirror.
* Amends `rr install` to also install Suggests dependencies (via `devtools::install_deps(dependencies = TRUE)`) during local installation.

# Version 1.15

* Adds `rr remove_trailing_spaces` and `rr tabs_to_spaces` for cleaning up R style guide violations.

# Version 1.14

* Adds `rr build` to build the package at the current directory into a compressed file suitable for installation or CRAN submission.

# Version 1.13

* Adds `rr check --strict` as a more thorough run of `R CMD CHECK` to prepare a package for CRAN submission.

# Version 1.12

* Adds `rr knit <target>` to use `knitr` to knit a file.
* Extends `rr install` to assume that `rr install -l` with no arguments refers to installing the package at the current working directory.

# Version 1.11

* Adds `rr vignettes` to make vignettes.

# Version 1.10

* `rr create` will also create the tests directory using testthat (through `devtools::use_testthat`).

# Version 1.9

* `rr install` now takes a flag `-l` to install from a local directory.

# Version 1.8

* `rr uninstall` will uninstall a package.

# Version 1.7.1

* A CRAN mirror is set for `rr install`.

# Version 1.7

* `rr rocco --no-pages` will run `rr rocco` without attempting to push to `gh_pages`.

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
