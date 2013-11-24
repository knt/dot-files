#!/bin/bash

#### Load RVM, if you are using it
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#### Paths
export PATH=/usr/local/bin:~/bin:$PATH
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH=/usr/local/bin:/usr/local/sbin:/Users/`whoami`/bin:/usr/local/share/npm/bin:$PATH
export EDITOR=/usr/bin/vim
export DEBUG_CAPISTRANO=true

command_exists () {
  type "$1" &> /dev/null ;
}

#### RBENV and RVM
# Only if rbenv exists
if command_exists rbenv; then
  eval "$(rbenv init -)"
fi
#source /Users/knt/.rvm/scripts/



#### Ruby Settings
export RUBY_HEAP_MIN_SLOTS=800000
export RUBY_HEAP_FREE_MIN=100000
export RUBY_HEAP_SLOTS_INCREMENT=300000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=79000000

##### These flags are useful for installing some tricky gemsets
#export ARCHFLAGS="-arch x86_64"
#export CC=/usr/bin/gcc
#export CC=/usr/bin/gcc-4.2

#### Git Completion
source ~/.git-completion.bash
export GIT_PS1_SHOWDIRTYSTATE=true # '*' for unstaged changes, '+' for staged
export GIT_PS1_SHOWSTASHSTATE=true # '$' if smth is stashed
export GIT_PS1_SHOWUNTRACKEDFILES=true # '%' if un-tracked files

# GIT
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function proml {
  local        NONE="\[\033[0m\]"
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  case $TERM in
    xterm*)
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac

PS1="${TITLEBAR}\
\u:\W$RED \$(parse_git_branch) \
$NONE$ "
PS2='> '
PS4='+ '
}
proml

#export PS1="\[\e[1;35m\]\h\[\e[m\] \w$ "
export PS1

#### Custom Functions and Shortcuts
###Custom Shortcuts
function grp { grep -riI --exclude=\*.log --exclude-dir="\.git;coverage" --color $1 .; }
function p { for f in $(ls -d ~/code/$1*); do cd $f; break; done; }
function k { for f in $(ls -d ~/knt/$1*); do cd $f; break; done; }
function m { for f in $(ls -d ~/code/$1*); do subl $f; break; done; }

# Open all unmerged files in Sublime
function conflicts { subl -n `git diff --name-only --diff-filter=U | tr "\\n" " "`; }

# Get SHA of parent commit
function parent { git log -1 --format="%P" | tr -d '\n'; }

#This fixes all commits for a repo to be my personal username...use with caution :)
function makeme {
  name='Nichole Treadway'
  email='kntreadway@gmail.com'
  git filter-branch -f --env-filter "GIT_AUTHOR_NAME='$name' GIT_AUTHOR_EMAIL='$email' GIT_COMMITTER_NAME='$name' GIT_COMMITTER_EMAIL='$name'" HEAD
}

#Git Diff Next - personal git workflow
export GDNPATH="$HOME/git_diff_next.rb"
function gdn { ruby $GDNPATH; }

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
source /Users/knt/.rvm/scripts/rvm

#Dash Documentation shortcut
function rdash { open dash://ruby:$1; }
function railsdash { open dash://rails:$1; }

# Find most used commands in bash history as alias candidates, from @rook
# history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head -20
# history | awk '{a[substr($0, index($0,$2))]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head -20

source ~/.aliases

#### Work Bash Profile
WORK_BASH="$HOME/.bash_profile_gr"
[[ -s $WORK_BASH ]] && source $WORK_BASH
