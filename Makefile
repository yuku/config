CONFIG_ROOT := $(realpath ./)
CANDIDATES  := $(wildcard dotfiles/.??*)
EXCLUSIONS  := .DS_Store .config
DOTFILES    := $(filter-out $(foreach val,$(EXCLUSIONS),dotfiles/$(val)),$(CANDIDATES))
INSTALLED   := $(shell find $(HOME) -maxdepth 1 -type l -exec readlink -n {} ';' -exec echo ':{}' ';' | grep $(CONFIG_ROOT) | cut -d: -f2)
CONFIG_DIRS := $(wildcard dotfiles/.config/*/)

.DEFAULT_GOAL := help

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

deploy: ## Create symlinks to home directory
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(notdir $(val));)
	@mkdir -p $(HOME)/.config
	@$(foreach val, $(CONFIG_DIRS), ln -sfnv $(abspath $(val)) $(HOME)/.config$(notdir $(val));)

clean: ## Remove symlinks from home directory
	@$(foreach val, $(INSTALLED), rm $(val);)

init: ## Setup environment settings
	@$(foreach val, $(wildcard ./etc/init/*.sh), CONFIG_ROOT=$(CONFIG_ROOT) bash $(CONFIG_ROOT)/$(val);)

update: ## Fetch changes for this repo
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

install: clean update deploy init ## Run make clean, update, deploy, init
	@exec $$SHELL

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: list deploy clean init update install help
