#!/bin/bash

#### Custom Functions and Shortcuts
###Custom Shortcuts
function grp { grep -riI --exclude=\*.log --exclude-dir={\.git,coverage,tmp} --color $1 .; }
function p { for f in $(ls -d $HOME/code/$1*); do cd $f; break; done; }
function k { for f in $(ls -d $HOME/knt/$1*); do cd $f; break; done; }
function m { for f in $(ls -d $HOME/code/$1*); do subl $f; break; done; }

# Open all unmerged files in Sublime
function conflicts { subl -n `git diff --name-only --diff-filter=U | tr "\\n" " "`; }

# Get SHA of parent commit
function parent { git log -1 --format="%P" | tr -d '\n'; }

#This fixes all commits for a repo to be my personal username...use with caution :)
function makeme {
  name='Nichole Treadway'
  email='kntreadway@gmail.com'
  git filter-branch -f --env-filter "GIT_AUTHOR_NAME='$name' GIT_AUTHOR_EMAIL='$email' GIT_COMMITTER_NAME='$name' GIT_COMMITTER_EMAIL='$email'" HEAD
}

#Dash Documentation shortcut
function rdash { open dash://ruby:$1; }
function railsdash { open dash://rails:$1; }

# Find most used commands in bash history as alias candidates, from @rook
function mostused { history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head -20; }
function mostusedl { history | awk '{a[substr($0, index($0,$2))]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head -20; }

[[ -s $SCRIPTS_HOME/git_review.sh ]] && source $SCRIPTS_HOME/git_review.sh