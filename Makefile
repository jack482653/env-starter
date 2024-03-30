SHELL:=/bin/bash
OS:=$(shell uname -s)
PWD:=$(shell pwd)

all: requirement sdkman nvm shell pyenv python poetry java node fonts vimrc ctags tmux utils devtools

vimrc:
	if [ ! -L $$HOME/.vimrc ]; then \
		cd $$HOME; \
		ln -s $(PWD)/.vimrc .vimrc; \
	fi
	if [ ! -d $$HOME/.vim/bundle/Vundle.vim ]; then \
		git clone https://github.com/VundleVim/Vundle.vim.git $$HOME/.vim/bundle/Vundle.vim; \
	fi
	vim +PluginInstall +qall
	cd ~/.vim/bundle/YouCompleteMe; ./install.py --clang-completer --gocode-completer

ctags:
	if [ ! -L $$HOME/.ctags ]; then \
		cd $$HOME; \
		ln -s $(PWD)/.ctags .ctags; \
	fi
	pwd

tmux:
	if [ ! -L $$HOME/.tmux.conf ]; then \
		cd $$HOME; \
		ln -s $(PWD)/.tmux.conf .tmux.conf; \
	fi

devtools:
	brew install --cask openvpn-connect visual-studio-code sourcetree notion docker slack fig; \
	brew install thefuck commitizen;

utils:
	brew install --cask raycast setapp;

fonts:
	brew tap homebrew/cask-fonts; \
	brew install --cask font-dejavu-sans-mono-nerd-font; \

sdkman:
	curl -s "https://get.sdkman.io" | bash; \
	source "$$HOME/.sdkman/bin/sdkman-init.sh"; \

java:
	sdk install java 20.0.1-open;

pyenv:
	brew install pyenv;

python:
	pyenv install 3.11; \
	pyenv global 3.11;

poetry:
	curl -sSL https://install.python-poetry.org | python3 - ; \
	mkdir "$$ZSH_CUSTOM/plugins/poetry"; \
	poetry completions zsh > "$$HOME/.oh-my-zsh/custom/plugins/poetry/_poetry";

nvm:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash;

node:
	nvm install --lts;

shell:
	brew install --cask iterm2; \
	brew install zsh; \
	if [ ! -L $$HOME/.zshrc ]; then \
		cd $$HOME; \
		rm .zshrc; \
		ln -s $(PWD)/.zshrc .zshrc; \
	fi
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; \
	git clone https://github.com/zsh-users/zsh-autosuggestions "$$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"; \
	curl -fsSL https://raw.githubusercontent.com/oskarkrawczyk/honukai-iterm/master/honukai.zsh-theme > "$$HOME/.oh-my-zsh/custom/themes/honukai.zsh-theme";


requirement:
	if [ $(OS) == "Darwin" ]; then \
		r=$$(xcode-select -p); \
		echo $$r;\
		if [ -z $$r ]; then \
   			xcode-select --install; \
		fi; \
		brew install coreutils cmake ripgrep jq xz go ncdu; \
	else \
		echo "Unsupported OS: $(OS)"; \
		exit 1; \
	fi
