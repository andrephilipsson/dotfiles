#!/bin/zsh

# Runs on login. Environmental variables are set here.

# ~/ Clean-up
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export GOPATH="$XDG_DATA_HOME"/go
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export R_ENVIRON_USER="$XDG_CONFIG_HOME/R/Renviron"

# Variables for Java language server
# export JAR="/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.100.v20201223-0822.jar"
# export GRADLE_HOME="/usr/share/java/gradle/"
# export JAVA_HOME="/usr/"
# export JDTLS_CONFIG="$XDG_DATA_HOME/jdtls/config_linux"
# export WORKSPACE="$XDG_CACHE_HOME/workspace"

export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$XDG_DATA_HOME/coursier/bin"
export PATH="$PATH:$HOME/bin"

# Default programs
export EDITOR=nvim
export BROWSER=firefox
export TERMINAL=alacritty