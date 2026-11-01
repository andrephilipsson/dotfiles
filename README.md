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

Once it's done, open a new terminal and create a non-exportable Secure Enclave
key for this Mac. Approve with Touch ID.

```sh
mkdir -p ~/.ssh &&
cd ~/.ssh &&
/usr/sbin/sc_auth create-ctk-identity -l ssh -k p-256-ne -t bio &&
/usr/bin/ssh-keygen -w /usr/lib/ssh-keychain.dylib -K -N "" &&
mv -i id_ecdsa_sk_rk_ssh id_secure_enclave &&
mv -i id_ecdsa_sk_rk_ssh.pub id_secure_enclave.pub
```

Leave the authenticator PIN blank and press Enter. The file without `.pub` is
a key reference, the private key stays in the Secure Enclave.

Add `~/.ssh/id_secure_enclave.pub` to GitHub as both an authentication key and
a signing key.

Sign in to the App Store, then open a new terminal and run bootstrap again. This time it picks up the App
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
