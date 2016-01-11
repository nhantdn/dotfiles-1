function powerline_precmd() {
  PS1="$(~/.powerline-shell/powerline-shell.py $? --shell zsh 2> /dev/null)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

function update() {
  # update zplug
  zplug update
  gem update

  # update version managers
  nodebrew selfupdate
  pushd ~/.rbenv;git pull origin master;popd
  pushd ~/.rbenv/plugins/ruby-build;git pull origin master;popd
  pushd ~/.pyenv;git pull origin master;popd
  pushd ~/.plenv:git pull origin master;popd
  pushd ~/.plenv/plugins/perl-build:git pull origin master;popd
  brew update
  brew upgrade
  clear
}

function sublimetext() {
  open -a Sublime\ Text $1
}

function tower() {
  open -a Tower $1
}

if [ "$TERM" != "linux" ]; then
  install_powerline_precmd
fi

if [ -n "$LS_COLORS" ]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# lang
export LANG=ja_JP.UTF-8

# show japanese files
setopt print_eight_bit

# set comment as #
setopt interactive_comments

# nodebrew, rbenv, pyenv
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"
