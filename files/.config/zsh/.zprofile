# Login shells run this after macOS's /etc/zprofile and path_helper.
export EDITOR=nvim
export VISUAL=nvim
export ANDROID_HOME="$HOME/Library/Android/sdk"
typeset -U PATH path
path=(
  "$HOME/.local/bin"
  # Resolve this file's symlink to find bin in the checkout.
  "${${(%):-%x}:A:h:h:h:h}/bin"
  "$HOME/.orbstack/bin"
  /opt/homebrew/bin
  /opt/homebrew/sbin
  "$ANDROID_HOME/platform-tools"
  "$ANDROID_HOME/emulator"
  $path
)
