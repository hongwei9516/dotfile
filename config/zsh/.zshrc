# ============================================== mac ==============================================
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt hist_expire_dups_first

# ============================================= zinit =============================================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit load wfxr/forgit

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$(brew --prefix)/share/zsh/site-functions:$FPATH

    autoload -Uz compinit
    compinit
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

zvm_before_init() {
  local ncur=$(zvm_cursor_style $ZVM_NORMAL_MODE_CURSOR)
  ZVM_INSERT_MODE_CURSOR=$ncur'\e\e]12;#929292\a'
  ZVM_NORMAL_MODE_CURSOR=$ncur'\e\e]12;#008800\a'
}

zvm_config() {
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
  ZVM_VI_ESCAPE_BINDKEY=jk
  ZVM_VI_INSERT_ESCAPE_BINDKEY=$ZVM_VI_ESCAPE_BINDKEY
  ZVM_VI_VISUAL_ESCAPE_BINDKEY=$ZVM_VI_ESCAPE_BINDKEY
  ZVM_VI_OPPEND_ESCAPE_BINDKEY=$ZVM_VI_ESCAPE_BINDKEY
  ZVM_VI_HIGHLIGHT_BACKGROUND=#519e97
}
zvm_after_init() {
  eval "$(fzf --zsh)"
}
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"

# autojump
[ -f $(brew --prefix)/etc/profile.d/autojump.sh ] && . $(brew --prefix)/etc/profile.d/autojump.sh

# ============================================= alias =============================================
alias proxy='export all_proxy=http://127.0.0.1:1087 && curl cip.cc'
alias unproxy='unset all_proxy && curl cip.cc'

alias ll='ls -alG'
alias df='df -h'
alias grep='grep --color=auto'


alias bat='bat --theme=Dracula'
alias nf='fastfetch'
alias ncdu='ncdu --color dark'
alias eza='eza -abghHliS --sort=Filename --icons'
alias lg='lazygit'
alias lzd='lazydocker'

alias ez='nvim $ZDOTDIR/.zshrc'

alias sz='source $ZDOTDIR/.zshrc'

# ============================================= common ============================================
export PATH=$(brew --prefix)/bin:$PATH

export EDITOR=nvim
export PATH=$HOME/.local/bin:$PATH

export MANPAGER='nvim +Man!'

export LESSHISTFILE=-

export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export NODE_OPTIONS='--trace-deprecation'

export PATH=$(brew --prefix)/opt/rustup/bin:$PATH
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export CARGO_HOME=$HOME/.local/share/cargo

if [[ $TERM_PROGRAM = "Apple_Terminal" ]]; then
    export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/hong.toml
else
    export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/default.toml
fi

# ============================================= fzf ===============================================
export FZF_COMPLETION_TRIGGER='\'

fl() {
  dir="$HOME/Documents/linux-command/command"
  commandsfile=$(find $dir -name '*.md' | sed "s#$dir/##; s/\.md//" \
      | fzf --prompt='LinuxCommands> ' --preview "echo $dir/{}.md | xargs -r mdcat -p" --preview-window=right,75% \
      | awk '{printf "'$dir'/%s.md", $1}')
  if [ $commandsfile ]; then
    glow --style dark -p $commandsfile
   else
     echo >> /dev/null
   fi
}

tl() {
    tldr --list | fzf --preview "tldr -R {1} | mdcat -p" --preview-window=right,60% | xargs tldr
}

# ============================================= yazi ==============================================
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# ============================================= tmux ==============================================
alias tnew='tmux -u new -s'
alias tat='tmux -u at -t'
alias tdt='tmux detach'
alias tls='tmux ls'
alias tkill='tmux kill-session -t'

# =========================================== (f)path =============================================
typeset -aU path
typeset -aU fpath
