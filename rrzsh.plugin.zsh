alias 'rv'='R --vanilla'
alias 'rn'='R --vanilla'

rr() {
  if [ $# -eq 0 ]; then; R
  elif [ $1 = "document" ]; then rr_document $@
  elif [ $1 = "vignettes" ]; then rr_vignettes $@
  elif [ $1 = "rocco" ]; then rr_rocco $@
  elif [ $1 = "knit" ]; then rr_knit $@
  elif [ $1 = "test" ]; then rr_test $@
  elif [ $1 = "send" ]; then rr_send $@
  elif [ $1 = "install" ]; then rr_install $@
  elif [ $1 = "uninstall" ]; then rr_uninstall $@
  elif [ $1 = "build" ]; then rr_build $@
  elif [ $1 = "create" ]; then rr_create $@
  elif [ $1 = "release" ]; then rr_release $@
  elif [ $1 = "check" ]; then rr_check $@
  elif [ $1 = "remove_trailing_spaces" ]; then rr_remove_trailing_spaces $@
  elif [ $1 = "tabs_to_spaces" ]; then rr_tabs_to_spaces $@
  else; Rscript -e $@
  fi
}

rr_document() {
  shift
  if [ $# -eq 0 ]; then; Rscript -e "library(methods); devtools::document()";
  else; Rscript -e "devtools::document($1)"
  fi
}

rr_vignettes() {
  shift
  if [ $# -eq 0 ]; then; local pkg="."
  else; local pkg="$1"
  fi
  Rscript -e "library(methods); devtools::build_vignettes(pkg = '$pkg', dependencies = 'VignetteBuilder')";
}

rr_rocco() {
  shift
  if [ $# -eq 0 ]; then; local should_gh_page="TRUE"
  else; local should_gh_page="FALSE"
  fi
  Rscript -e "library(whisker); library(markdown); library(rocco); library(methods); library(devtools); rocco(, gh_pages = $should_gh_page)"
}

rr_knit() {
  shift
  if [ $# -eq 0 ]; then; echo "Need a target to knit."
  else; 
    Rscript -e "library(methods); knitr::knit('$1')";
  fi
}

rr_test() {
  shift
  if [ $# -eq 0 ]; then; Rscript -e "library(methods); library(devtools); test()";
  elif [ $# -eq 1 ]; then; Rscript -e "library(methods); library(devtools); test('$1')";
  else; Rscript -e "library(methods); library(devtools); test('$1', '$2')";
  fi
}

rr_install() {
  shift
  if [ $# -eq 0 ]; then echo "You need to specify the package to install.";
  elif [ $1 == "-l" ]; then
    if [ $# -eq 1 ]; then local pkg=".";
    else; local pkg="$2"
    fi
    echo "Installing $pkg from local"
    Rscript -e "library(methods); library(devtools); install('$pkg');"
    echo "Installing dependencies..."
    Rscript -e "library(methods); library(devtools); install_deps('$pkg', dependencies = TRUE)"
  elif grep -q "/" <<< "$1"; then
    echo "Installing $1 from GitHub"
    Rscript -e "library(methods); library(devtools); install_github('$1');"
  else
    echo "Installing $1 from CRAN..."
    Rscript -e "library(methods); options(repos=structure(c(CRAN='http://cran.rstudio.com'))); install.packages('$1');"
  fi
}

rr_uninstall() {
  shift
  if [ $# -eq 0 ]; then echo "You need to specify the package to install.";
  else
    echo "Removing $1..."
    Rscript -e "remove.packages('$1', .libPaths())"
  fi
}

rr_build() {
  R CMD BUILD .
}

rr_create() {
  shift
  if [ $# -eq 0 ]; then echo "You need to specify the name of the package to create.";
  else Rscript -e "library(methods); library(devtools); create('$1'); use_testthat('$1')"
  cd $1;
  fi
}

rr_release() {
  git checkout master
  git pull origin master
  local version=`head DESCRIPTION | grep "Version" | awk '{print $2}'`
  git tag $version && git push origin $version
}

rr_pull_or_push() {
  if [ $# -eq 2 ]; then
    git $1 -q $2 `git rev-parse --abbrev-ref HEAD`
  else
    git $1 -q origin `git rev-parse --abbrev-ref HEAD`
  fi
}

rr_pull() {
  rr_pull_or_push "pull" $@
}

rr_push() {
  rr_pull_or_push "push" $@ &
}

rr_send() {
  shift
  print "Documenting..."
  rr_document 'shift'
  print "Committing..."
  git add "$(git rev-parse --show-toplevel)"
  if [ $# -eq 1 ]; then
   git commit -a -m "$1"
  else
   git commit -a -m "I'm too lazy to write a commit message."
  fi
  print "Pulling..."
  rr_pull
  print "Pushing..."
  rr_push
}

__rr_internal_cleanup_after_check() {
  rm -rf *.Rcheck; rm -rf ..Rcheck; rm -rf *.tar.gz
}
rr_check() {
  shift
  if [ $# -eq 0 ]; then Rscript -e "library(methods); library(devtools); check()";
  elif [ $1 == "--strict" ]; then
    rr_document 'shift'
    __rr_internal_cleanup_after_check
    R CMD BUILD .; R CMD CHECK *.tar.gz --as-cran --timings --run-donttest
    if [ $# -eq 1 ] || [ $2 != "--keep" ]; then
      __rr_internal_cleanup_after_check
    fi
  else Rscript -e "library(methods); library(devtools); check('$1')";
  fi
}

rr_remove_trailing_spaces() {
  find . -type f -name "*.R" -exec sed -i '' -e 's/[[:space:]]*$//' {} \;
}

rr_tabs_to_spaces() {
  find . -type f -name "*.R" -exec sed -i '' -e $'s/\t/  /g' {} \;
}
