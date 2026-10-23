# Dotfiles

My personal dotfiles. It's mostly here so I can get a new machine running
quickly, but feel free to poke around and borrow whatever you like.

As I do almost all of my development in
[Orbs](https://ampcode.com/what-are-orbs), this is intentionally very minimal.

## New Mac

Install the Command Line Tools first:

```sh
xcode-select --install
```

Then clone the repo and run bootstrap:

```sh
mkdir -p ~/Developer
git clone https://github.com/andrephilipsson/dotfiles.git ~/Developer/dotfiles
cd ~/Developer/dotfiles
./bin/mise trust
./bin/mise bootstrap
```

It asks for a computer name and hostname, then installs everything except the
App Store apps.

Once it's done, sign in to 1Password and turn on the SSH agent under
Settings > Developer. Check it with `ssh -T git@github.com`, then sign in to
the App Store.

Open a new terminal and run bootstrap again. This time it picks up the App
Store apps and switches the repo over to SSH:

```sh
cd ~/Developer/dotfiles
./bin/mise bootstrap
```

Last thing: install
[Berkeley Mono](https://usgraphics.com/products/berkeley-mono) by hand. It's
licensed, so it's not in here.

## Commands

```sh
./bin/mise bootstrap                  # apply changes
./bin/mise bootstrap --upgrade        # apply and upgrade packages
./bin/mise bootstrap --only dotfiles  # just relink dotfiles
./bin/mise run configure-hostname     # rename the Mac (edit mise.local.toml first)
```

Removing a package from `mise.toml` doesn't uninstall it. Use
`./bin/mise bootstrap packages prune --dry-run` to see what would go.
