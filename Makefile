OS:=$(shell uname -s)

all: requirement vimrc ctags

vimrc:
	if [ ! -L $$HOME/.vimrc ]; then \
		ln -s .vimrc $$HOME/.vimrc; \
	fi
	if [ ! -d $$HOME/.vim/bundle/Vundle.vim ]; then \
		git clone https://github.com/VundleVim/Vundle.vim.git $$HOME/.vim/bundle/Vundle.vim; \
	fi
	vim +PluginInstall +qall
	cd ~/.vim/bundle/YouCompleteMe; ./install.py --clang-completer --gocode-completer

ctags:
	ln -s .ctags $$HOME/.ctags

tmux:
	cp .tmux.conf $$HOME/.tmux.conf

requirement:
	if [ $(OS) == "Darwin" ]; then \
		r=$$(xcode-select -p); \
		echo $$r;\
		if [ -z $$r ]; then \
   			xcode-select --install; \
		fi; \
		brew install cmake; \
	elif [ $(OS) == "Linux" ]; then \
		sudo apt install build-essential cmake python-dev python3-dev exuberant-ctags; \
	else \
		echo "Unsupported OS: $(OS)"; \
		exit 1; \
	fi
