set fish_greeting ""

alias cat="bat"
alias e="exit"
alias g="git"
alias l="ls -l"
alias ll="ls -la"
alias ls="eza"
alias t="tmux"

set -x ANDROID_HOME "$HOME/Library/Android/sdk"
fish_add_path "$ANDROID_HOME/emulator"
fish_add_path "$ANDROID_HOME/platform-tools"

fish_add_path "/opt/homebrew/bin"
fish_add_path "$HOME/.orbstack/bin"
fish_add_path "$HOME/Developer/dotfiles/bin"

if isatty
    set -x GPG_TTY (tty)
end

if status is-interactive
    source ~/.orbstack/shell/init2.fish 2>/dev/null || :

    # Load Ghostty's shell integration in sub-shells, e.g. when running `flox activate`
    if test -n "$GHOSTTY_RESOURCES_DIR"
        source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
    end
end
