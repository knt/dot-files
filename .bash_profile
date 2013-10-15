#!/bin/bash

#### Load RVM, if you are using it
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#### Paths
export PATH=/usr/local/bin:~/bin:$PATH
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH=/usr/local/bin:/usr/local/sbin:/Users/`whoami`/bin:/usr/local/share/npm/bin:$PATH
export EDITOR=/usr/bin/vim
export DEBUG_CAPISTRANO=true


#### Work Bash Profile
source ~/.bash_profile_gr


#### RBENV and RVM
eval "$(rbenv init -)"
#source /Users/knt/.rvm/scripts/

#### Javascript Console
alias jsc=/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc

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

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1='\W $ '

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
\u@\h:\W$RED \$(parse_git_branch) \
$NONE$ "
PS2='> '
PS4='+ '
}
proml

#export PS1="\[\e[1;35m\]\h\[\e[m\] \w$ "
export PS1


#### Custom Functions and Shortcuts
#from bmuller
function grp { grep -riI --exclude=\*.log --exclude-dir="\.git;coverage" --color $1 .; }
function p { for f in $(ls -d ~/code/$1*); do cd $f; break; done; }
function k { for f in $(ls -d ~/knt/$1*); do cd $f; break; done; }
function m { for f in $(ls -d ~/code/$1*); do subl $f; break; done; }

alias knt='cd ~/code'

# Git and other Shortcuts
alias be='bundle exec'
alias bi='bundle install'
alias br='branch'
alias g='git'
alias ga='git add'
alias gd='git diff'
alias gbr='git branch'
alias gco='git co'
alias gr='cd ~/code/gr'
alias gp='git pull origin master'
alias gpr='git pull --rebase origin master'
alias gst='git status'
alias ls='ls -Ga'
alias rt='ruby -Ilib'
alias st='status'

# Open all unmerged files in Sublime
function mergeum { subl -n `git diff --name-only --diff-filter=U | tr "\\n" " "`; }

#This fixes all commits for a repo to be my personal username...use with caution :)
# alias makeme='git filter-branch -f --env-filter "GIT_AUTHOR_NAME=\'Nichole Treadway\' GIT_AUTHOR_EMAIL=\'kntreadway@gmail.com\' GIT_COMMITTER_NAME=\'Nichole Treadway\'
# GIT_COMMITTER_EMAIL=\'kntreadway@gmail.com\'" HEAD"

#Git Diff Next - personal git workflow
export GDNPATH="$HOME/git_diff_next.rb"
function gdn { ruby $GDNPATH; }

#Dash Documentation shortcut
function rdash { open dash://ruby:$1 }
function railsdash { open dash://rails:$1 }

#Exit the current directory and reenter it; useful for reloading .rvrmc
alias reenter='current=`pwd`; cd ..; cd $current'

# Find most used commands in bash history as alias candidates, from @rook
# history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head -20
# history | awk '{a[substr($0, index($0,$2))]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head -20