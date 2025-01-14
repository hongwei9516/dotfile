# homebrew
get_arch=`arch`
if [[ $get_arch =~ "arm64" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi
# custom install
# export HOMEBREW_NO_INSTALL_FROM_API=1

# xdg
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# zdotdir
export ZDOTDIR=$HOME/.config/zsh
