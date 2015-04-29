alias 'rv'='R --vanilla'

rr() {
  if [ $# -eq 0 ]; then; R
  elif [ $1 = "document" ]; then rr_document $@
  elif [ $1 = "test" ]; then rr_test $@
  elif [ $1 = "send" ]; then rr_send $@
  elif [ $1 = "install" ]; then rr_install $@
  elif [ $1 = "install_github" ]; then rr_install_github $@
  else; Rscript -e $@
  fi
}

rr_document() {
  shift
  if [ $# -eq 0 ]; then; Rscript -e "devtools::document()";
  else; Rscript -e "devtools::document($1)"
  fi
}

rr_test() {
  shift
  if [ $# -eq 0 ]; then; Rscript -e "library(methods); library(devtools); test()";
  else; Rscript -e "library(methods); library(devtools); test($1)"
  fi
}

rr_install() {
  shift
  if [ $# -eq 0 ]; then; Rscript -e "library(methods); library(devtools); install()";
  else; Rscript -e "library(methods); library(devtools); install($1);"
  fi
}

rr_install_github() {
  shift
  if [ $# -eq 0 ]; then echo "You need to specify the repo.";
  else; Rscript -e "library(methods); library(devtools); install_github('$1');"
  fi
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
  print "Testing..."
  rr_test 'shift'
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
