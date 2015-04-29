# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
###################################### moje vlastní aliasy
alias aram="sudo ifconfig aramis up; sudo edge -d aramis -a 10.2.2.1 -c aramis -k shabat-shalom -l 88.86.108.50:82 -f; sleep 1 && ssh -C root@aram-nettop"
alias kladruby="sudo ifconfig kladruby up; sudo edge -d kladruby -a 10.3.3.1 -c kladruby -k linux4u -l 88.86.108.50:82 -f; sleep 1 && ssh -C root@kladruby-desktop"
alias jindra="sudo ifconfig kladruby up; sudo edge -d kladruby -a 10.3.3.1 -c kladruby -k linux4u -l 88.86.108.50:82 -f; sleep 1 && ssh -C root@jindra"
alias rys="sudo ifconfig kladruby up; sudo edge -d kladruby -a 10.3.3.1 -c kladruby -k linux4u -l 88.86.108.50:82 -f; sleep 1 && ssh -C root@rys"
alias rychlost="cd ~/Dropbox/Linux/speedtest && ./spustit.sh"

# alias aram='ssh -C root@aram-nettop'

alias renata='ssh -C root@renata-netbook'

alias medved="ssh medved@medved"
alias vypnout='dbus-send --system --print-reply --dest=org.freedesktop.ConsoleKit /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop'
alias restart='dbus-send --system --print-reply --dest=org.freedesktop.ConsoleKit /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Restart'
alias grub="sudo update-grub"
alias up="apt-fast update; apt-fast -y upgrade; apt-fast purge ~c"
alias galerie-dropbox='pkexec --user galerie dropbox start -y'
alias pl="rm *.jpg; rm *utorun*; rm -rf covers*; rm *.ico; rm *.png; rm *.ini; rm *txt; rm *htm*; rm *thumbs.db; rm booklet/*; rmdir booklet; rm *m3u; detox *; ls -1 > "`pwd`.m3u" && mv "`pwd`.m3u" `pwd`"
alias tailsec="sudo tail /var/log/security.log"
alias moresec="sudo more /var/log/security.log"
alias catsec="sudo cat /var/log/security.log"
alias tor="~/bin/tor-browser_en-US/start-tor-browser"
alias chromer="/usr/bin/chrome-kill"
alias m="mocp -m ~/Hudba -T transparent-background"
alias m2="mocp -m Stažené/THE* -T transparent-background"
alias lynx="lynx -accept_all_cookies google.cz"
alias github="/home/medved/Dropbox/Linux/github.com.sh"
alias gitlab="/home/medved/Dropbox/Linux/github.com.sh"
alias webarna="/home/medved/Dropbox/Linux/webarna.sh"
alias edithostsweb="/home/medved/Dropbox/Linux/edithostsweb.sh"
alias zrychleni="/home/medved/Dropbox/Linux/zrychleni.sh"
alias webovkylevne="/home/medved/Dropbox/Linux/webovkylevne.sh"
alias wordpressexample="/home/medved/Dropbox/Linux/wordpress-example.sh"
alias wordpress="/home/medved/Dropbox/Linux/wordpress.sh"
