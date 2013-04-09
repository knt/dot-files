#!/bin/bash
# Load RVM, if you are using it
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

# Load work
[[ -s $HOME/.bash_ls ]] && source $HOME/.bash_ls

######Javascript Console
alias jsc=/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc

######Paths
# MacPorts Installer addition on 2012-01-20_at_13:27:24: adding an appropriate PATH variable for use with MacPorts.
#export PATH=/opt/local/bin:/opt/local/sbin:$PATH
#export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export EDITOR=/usr/bin/vim

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

###### These flags are useful for installing some tricky gemsets
#export ARCHFLAGS="-arch x86_64"
#export CC=/usr/bin/gcc
#export CC=/usr/bin/gcc-4.2

######Custom Functions

#from bmuller
function g { grep -RiI --color $1 .; }
function p { for f in $(ls -d ~/code/$1*); do cd $f; break; done; }
function k { for f in $(ls -d ~/knt/$1*); do cd $f; break; done; }
function m { for f in $(ls -d ~/code/$1*); do mate $f; break; done; }

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
\u@\h:\W$RED \$(parse_git_branch) \
$NONE$ "
PS2='> '
PS4='+ '
}
proml

#export PS1="\[\e[1;35m\]\h\[\e[m\] \w$ "
export PS1

###Custom
alias knt='cd ~/knt'
alias be='bundle exec'
alias bi='bundle install'
alias gd='git diff'
alias ga='git add'
alias gst='git st'

#This fixes all commits for a repo to be my personal username...use with caution :)
alias makeme='git filter-branch -f --env-filter "GIT_AUTHOR_NAME=\'Nichole Treadway\' GIT_AUTHOR_EMAIL=\'kntreadway@gmail.com\' GIT_COMMITTER_NAME=\'Nichole Treadway\' GIT_COMMITTER_EMAIL=\'kntreadway@gmail.com\'" HEAD"

#Exit the current directory and reenter it; useful for reloading .rvrmc
alias reenter='current=`pwd`; cd ..; cd $current'
