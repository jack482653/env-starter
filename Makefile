HOME:="~"
OS:=$(shell uname)

all: requirement  vimrc ctags

vimrc:
	cp .vimrc $(HOME)/.vimrc
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
	cd ~/.vim/bundle/YouCompleteMe; ./install.py --clang-completer

ctags:
	cp .ctags $(HOME)/.ctags

requirement:
	ifeq ($(OS), Darwin)
		xcode-select --install; \
		brew install cmake
	else ifeq ($(OS), Linux)
		sudo apt install build-essential cmake python-dev python3-dev exuberant-ctags
	else
		$(error Unsupported OS)
	endif

