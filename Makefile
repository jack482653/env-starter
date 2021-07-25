SHELL:=/bin/bash
OS:=$(shell uname -s)
PWD:=$(shell pwd)

all: requirement sdkman java shell fonts vimrc ctags tmux utils devtools

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
	brew install --cask openvpn-connect visual-studio-code;

utils:
	brew install alfred;

fonts:
	brew tap homebrew/cask-fonts; \
	brew install --cask font-dejavusansmono-nerd-font-mono; \

sdkman:
	curl -s "https://get.sdkman.io" | bash; \
	source "$HOME/.sdkman/bin/sdkman-init.sh"; \

java:
	sdk install java 11.0.11.hs-adpt;

shell:
	brew install --cask iterm2; \
	brew install zsh; \
	if [ ! -L $$HOME/.zshrc ]; then \
		cd $$HOME; \
		ln -s $(PWD)/.zshrc .zshrc; \
	fi
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; \

requirement:
	if [ $(OS) == "Darwin" ]; then \
		r=$$(xcode-select -p); \
		echo $$r;\
		if [ -z $$r ]; then \
   			xcode-select --install; \
		fi; \
		brew install coreutils cmake ripgrep; \
	else \
		echo "Unsupported OS: $(OS)"; \
		exit 1; \
	fi
