[[ -o interactive ]] || return

# Login shells have already read this; also support /bin/zsh from tmux.
if [[ ! -o login ]]; then
  source "$ZDOTDIR/.zprofile"
fi

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

typeset -U fpath
fpath=("$ZDOTDIR/functions" /opt/homebrew/share/zsh/site-functions $fpath)
autoload -Uz git scratch
# Initialize completion on first use, including the normal security checks.
_main_complete() {
  autoload -Uz compinit
  if [[ ! -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" ]]; then
    mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
  fi
  compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$HOST-$ZSH_VERSION" || return
  if [[ -f "$_comp_dumpfile" && ( ! -f "$_comp_dumpfile.zwc" || "$_comp_dumpfile" -nt "$_comp_dumpfile.zwc" ) ]]; then
    zcompile "$_comp_dumpfile"
  fi
  # compinit replaces completion widgets; restore their suggestion wrappers.
  (( $+functions[_zsh_autosuggest_bind_widgets] )) && _zsh_autosuggest_bind_widgets
  unfunction _main_complete
  autoload -Uz _main_complete
  _main_complete "$@"
}
for _completion_widget in complete-word delete-char-or-list expand-or-complete \
  expand-or-complete-prefix list-choices menu-complete \
  menu-expand-or-complete reverse-menu-complete; do
  zle -C $_completion_widget .$_completion_widget _main_complete
done
unset _completion_widget
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

autoload -Uz prompt-init
prompt-init

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

# Bind once at the first prompt, and once when completion initializes.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
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

# Activate after PATH setup. Keep directory/command updates, but do no external
# work for an empty Enter. Activation already applies the initial environment.
eval "$(mise activate zsh)"
# The first actual command must not take mise's unchanged-startup shortcut.
__MISE_ZSH_PRECMD_RUN=1
_mise_refresh=0
_mise_preexec() { _mise_refresh=1 }
_mise_precmd() {
  (( _mise_refresh )) || return 0
  _mise_refresh=0
  [[ -n $MISE_SHELL ]] || return 0
  _mise_hook_precmd
}
add-zsh-hook -d precmd _mise_hook_precmd
add-zsh-hook preexec _mise_preexec
add-zsh-hook precmd _mise_precmd
