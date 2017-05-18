DOTFILES_EXCLUDES := .DS_Store .git .gitmodules .travis.yml Makefile README.md etc doc bin
DOTFILES_TARGET   := $(wildcard *)
DOTFILES_DIR      := $(PWD)
DOTFILES_FILES    := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))

deploy:
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)
	ln -sfnv $(abspath bin) $(HOME)/bin

init:
	@$(foreach val, $(wildcard ./etc/init/*.sh), bash $(val);)