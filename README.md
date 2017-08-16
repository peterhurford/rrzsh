
A plugin for R commands from your terminal.

* `rr` - opens your R console.

* `rv` - opens your R console without sourcing your `~/.Rprofile`.  (equivalent to `R --vanilla`)

* `rr document` - documents the R package that you are in.  `rr document <path/to/package>` documents that package (e.g., `rr document ~/dev/package`).

* `rr knit <file>` to knit a file using [knitr](https://yihui.name/knitr/).

* `rr vignettes` to build vignettes.

* `rr rocco` - compiles your [rocco documentation](https://github.com/robertzk/rocco).  `rr rocco --no-pages` will run `rr rocco` without attempting to push to `gh_pages`.

* `rr test` - runs the tests for the package you are in.  `rr test <path/to/package>` tests that package (e.g., `rr test ~/dev/package`).  `rr test <path/to/package> <file>` will test a file within that package (e.g., `rr test . file`).

* `rr install` - installs a package.  `rr install <package name>` installs that package from CRAN.  `rr install -l <path to package>` installs from your local directory.  `rr install <github_username>/<github_repo>` installs that package via `devtools::install_gihtub` (e.g., `rr install devtools`, `rr install -l ~/dev/checkr`, `rr install peterhurford/batchman`).

* `rr uninstall` - uninstalls a package.  `rr uninstall <package name>` uninstalls that package from every folder in your `.libPaths()` (e.g., `rr uninstall devtools`).

* `rr send <commit message>` - Like [send.zsh](https://github.com/robertzk/send.zsh), but hacked to include R.  If your repo is not a package, it will do `git add .`, `git commit -a -m <commit message>` and `git push origin <the branch you are on>`.  If you are in an R package directory, before doing that, it will document your code using Roxygen.

* `rr create <packagename>` - Creates a new R package scaffold, using `devtools::create`.  But you may prefer [using a Yeoman generator](https://github.com/kirillseva/generator-newpackage) which includes Travis CI and Covr.

* `rr release` - Automatically reads the package version from the `DESCRIPTION` file and releases at that version on git (`git tag` + `git push`).
 
* `rr check` - Runs `R CMD CHECK` (via `devtools::check`). Use `rr check --strict` to run `R CMD CHECK` via the command line with more strict settings that are intended for CRAN submission preparation. Run `rr check --strict --keep` to keep the resulting check logs and build file.

* `rr <command>` - runs that command in R.  `rr "mean(2, 4, 5)"` outputs 2.  One cool tip is to use this to access man pages, e.g., `rr "?mean"`.


## Installation

### Oh-My-Zsh

Assuming you have [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh), you can
simply write:

```bash
git clone git@github.com:peterhurford/rrzsh.git ~/.oh-my-zsh/custom/plugins/rrzsh
echo "plugins+=(rrzsh)" >> ~/.zshrc
```

(Alternatively, you can place the `rrzsh` plugin in the `plugins=(...)` local in your `~/.zshrc` manually.)

### Antigen
If you're using the [Antigen](https://github.com/zsh-users/antigen) framework for ZSH, all you have to do is add `antigen bundle peterhurford/rrzsh` to your `.zshrc` wherever you're adding your other antigen bundles. Antigen will automatically clone the repo and add it to your antigen configuration the next time you open a new shell.

### Bash
If you use the non-recommended alternative, bash, you can install this directly to you
r `~/.bash_profile`:

```bash
curl -s https://raw.githubusercontent.com/peterhurford/rrzsh/master/rzsh.plugin.zsh >>
~/.bash_profile
```
