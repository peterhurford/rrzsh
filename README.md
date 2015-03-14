## rrzsh - A pirate's favorite plugin.

A plugin for R commands from your terminal.

* `rr` - opens your R console.

* `rr document` - documents the R package that you are in.  `rr document <path/to/package>` documents that package (e.g., `rr document ~/dev/package`).

* `rr test` - runs the dests for the package you are in.  `rr test <path/to/package>` tests that package (e.g., `rr test ~/dev/package`).

* `rr send <commit message>` - Like [send.zsh](https://github.com/robertzk/send.zsh), but hacked to include R.  If your repo is not a package, it will do `git add .`, `git commit -a -m <commit message>` and `git push origin <the branch you are on>`.  If you are in an R package directory, before doing that, it will document your code and run your tests.

* `rr <command>` - runs that command in R.  `rr "mean(2, 4, 5)"` outputs 2.
