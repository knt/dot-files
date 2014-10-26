#!/bin/bash

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
export RUBY_GC_HEAP_INIT_SLOTS=800000
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

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo " 💩 "
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
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

# TO-DO: FIX
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"
# source /Users/knt/.rvm/scripts/rvm


export CODE_DIR=$HOME/code

# Work Bash Profile
export WORK_BASH=$HOME/.bash_profile_gr
[[ -s $WORK_BASH ]] && source $WORK_BASH

export BASH_FILES_HOME=$CODE_DIR/dot-files
export SCRIPTS_HOME=$CODE_DIR/scripts

source $BASH_FILES_HOME/.bash_functions
source $BASH_FILES_HOME/.aliases

#### Load RVM, if you are using it
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

