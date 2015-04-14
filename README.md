## rrzsh - A pirate's favorite plugin.

A plugin for R commands from your terminal.

* `rr` - opens your R console.

* `rn` - opens your R console without sourcing your `~/.Rprofile`.  (equivalent to `R --no-init-file`)

* `rr document` - documents the R package that you are in.  `rr document <path/to/package>` documents that package (e.g., `rr document ~/dev/package`).

* `rr test` - runs the tests for the package you are in.  `rr test <path/to/package>` tests that package (e.g., `rr test ~/dev/package`).

* `rr install` - installs a package.  `rr install <path/to/package>` installs that package (e.g., `rr install ~/dev/package`).

* `rr send <commit message>` - Like [send.zsh](https://github.com/robertzk/send.zsh), but hacked to include R.  If your repo is not a package, it will do `git add .`, `git commit -a -m <commit message>` and `git push origin <the branch you are on>`.  If you are in an R package directory, before doing that, it will document your code and run your tests.

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
