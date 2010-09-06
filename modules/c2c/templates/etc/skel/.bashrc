# ~/.bashrc: executed by bash(1) for non-login shells.

export LESS='-q'
export EDITOR=vim

# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto'
export HISTCONTROL=ignoredups
eval `dircolors`
alias ls='ls $LS_OPTIONS'
alias l='ls $LS_OPTIONS -Fahl'

# Some more alias to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

if [ `id -u` -eq 0 ]; then
  umask 022
  <% if has_variable?("ps1label") %>
  export PS1='\[\033[31m\]\u@\h (<%= ps1label %>):\w\[\033[39m\]\$ '
  <% else %>
  export PS1='\[\033[31m\]\u@\h:\w\[\033[39m\]\$ '
  <% end %>
  export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/bin/X11:/usr/games"
else
  <% if has_variable?("ps1label") %>
  export PS1='\[\033[01;32m\]\u@\h (<%= ps1label %>)\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  <% else %>
  export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  <% end %>
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
   PATH=~/bin:"${PATH}"
fi

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi