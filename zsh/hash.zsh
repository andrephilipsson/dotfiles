# Shortcuts for paths.
# (eg. cd ~www; but also, `jump www`/`j www`)
# For a full list, run `hash -d` (alias `d`).

local PRIVATE="$ZSH/zsh/hash.private"
if grep 'com\.wincent\.git-cipher' "$PRIVATE" &> /dev/null; then
  # Don't source still-encrypted file.
else
  # Source it if it's actually there.
  test -e "$PRIVATE" && source "$PRIVATE"
fi
