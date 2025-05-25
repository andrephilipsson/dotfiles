.PHONY: bootstrap default

default:
	stow --target=$(HOME) files
	brew bundle --zap
	./script/defaults

bootstrap:
	./script/bootstrap
