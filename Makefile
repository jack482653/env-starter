SHELL:=/bin/bash
OS:=$(shell uname -s)
PWD:=$(shell pwd)

all: requirement vimrc ctags tmux

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

requirement:
	if [ $(OS) == "Darwin" ]; then \
		r=$$(xcode-select -p); \
		echo $$r;\
		if [ -z $$r ]; then \
   			xcode-select --install; \
		fi; \
		brew install cmake; \
		brew tap caskroom/fonts; \
		brew cask install font-dejavusansmono-nerd-font-mono; \
	elif [ $(OS) == "Linux" ]; then \
		sudo apt install build-essential cmake python-dev python3-dev exuberant-ctags; \
	else \
		echo "Unsupported OS: $(OS)"; \
		exit 1; \
	fi
