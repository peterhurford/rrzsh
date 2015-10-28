alias 'rv'='R --vanilla'
alias 'rn'='R --vanilla'

rr() {
  if [ $# -eq 0 ]; then; R
  elif [ $1 = "document" ]; then rr_document $@
  elif [ $1 = "rocco" ]; then rr_rocco $@
  elif [ $1 = "test" ]; then rr_test $@
  elif [ $1 = "send" ]; then rr_send $@
  elif [ $1 = "install" ]; then rr_install $@
  elif [ $1 = "create" ]; then rr_create $@
  elif [ $1 = "release" ]; then rr_release $@
  else; Rscript -e $@
  fi
}

rr_document() {
  shift
  if [ $# -eq 0 ]; then; Rscript -e "devtools::document()";
  else; Rscript -e "devtools::document($1)"
  fi
}

rr_rocco() {
  Rscript -e "library(whisker); library(markdown); library(rocco); rocco(, gh_pages = TRUE)"
}

rr_test() {
  shift
  if [ $# -eq 0 ]; then; Rscript -e "library(methods); library(devtools); test()";
  else; Rscript -e "library(methods); library(devtools); test('$1')"
  fi
}

rr_install() {
  shift
  if [ $# -eq 0 ]; then echo "You need to specify the package to install.";
  elif grep -q "/" <<< "$1"; then
    echo "Installing $1 from GitHub"
    Rscript -e "library(methods); library(devtools); install_github('$1');"
  else
    echo "Installing $1 from CRAN..."
    Rscript -e "library(methods); install.packages('$1');"
  fi
}

rr_create() {
  shift
  if [ $# -eq 0 ]; then echo "You need to specify the name of the package to create.";
  else Rscript -e "library(methods); library(devtools); create('$1');"; cd $1
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
