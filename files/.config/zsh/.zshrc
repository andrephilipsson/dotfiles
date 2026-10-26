[[ -o interactive ]] || return

# Login shells have already read this; also support /bin/zsh from tmux.
if [[ ! -o login ]]; then
  source "$ZDOTDIR/.zprofile"
fi

# Update tools and environment variables when changing directories.
eval "$(mise activate zsh)"

if [[ -t 0 ]]; then
  export GPG_TTY=$TTY
fi

alias cat='bat'
alias e='exit'
alias g='git'
alias ls='eza'
alias l='eza -l'
alias ll='eza -la'
alias t='tmux'
alias vim='nvim'

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS
setopt HIST_VERIFY HIST_IGNORE_SPACE
setopt AUTO_CD INTERACTIVE_COMMENTS

bindkey -e

# Load OrbStack's completion paths before starting completion.
if [[ -f "$HOME/.orbstack/shell/init.zsh" ]]; then
  source "$HOME/.orbstack/shell/init.zsh"
fi

fpath=("$ZDOTDIR/functions" /opt/homebrew/share/zsh/site-functions $fpath)
autoload -Uz git scratch
autoload -Uz compinit
if [[ ! -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" ]]; then
  mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
fi
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$HOST-$ZSH_VERSION"
# Compile the completion cache when it changes; keep compinit's security checks.
if [[ -f "$_comp_dumpfile" && ( ! -f "$_comp_dumpfile.zwc" || "$_comp_dumpfile" -nt "$_comp_dumpfile.zwc" ) ]]; then
  zcompile "$_comp_dumpfile"
fi
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

PROMPT='%F{cyan}%~%f %# '

# Also enable Ghostty integration in shells started from tmux.
if [[ -n "$GHOSTTY_RESOURCES_DIR" && -r "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration" ]]; then
  source "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration"
fi

# fzf: Ctrl+R searches history; Ctrl+T selects files; Alt+C selects directories.
if [[ -r /opt/homebrew/opt/fzf/shell/completion.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/completion.zsh
fi
if [[ -r /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
fi

if [[ -r /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
if [[ -r /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# This plugin must load after syntax highlighting.
if [[ -r /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
  source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh

  # Keep fish-like history search on Up/Down.
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey '^[OA' history-substring-search-up
  bindkey '^[OB' history-substring-search-down
fi
