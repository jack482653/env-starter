set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'gerw/vim-latex-suite'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'jnurmine/Zenburn'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/emmet-vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdTree'
Plugin 'scrooloose/syntastic'
Plugin 'sheerun/vim-polyglot'
Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
set tabstop=4		" show existing tab with 4 spaces width
set shiftwidth=4	" when indenting with '>', use 4 spaces width
set noexpandtab

" * Vim Setting ***
set colorcolumn=80
set showtabline=2	" show tab line
set laststatus=2	" show status line
set nu			" Show number line
set t_Co=256		" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set clipboard=unnamed	" enable accessing system clipboard
set hlsearch		" highlight searaching result
set encoding=utf-8
scriptencoding utf-8
syntax on
colorscheme zenburn	" theme


" *** airline ***
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


" flake8
autocmd BufWritePost *.py call Flake8()


" *** NERDtree ***
" autostart NERDtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" ignore file
let NERDTreeIgnore = ['\.pyc$']


" *** syntastic ***
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" *** tagbar ***
autocmd BufEnter * nested :call tagbar#autoopen(0)

" *** vim-indent-guides ***
" let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
autocmd VimEnter * IndentGuidesToggle
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=black
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey

" Youcompleteme fix
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" *** latex ***
set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
let g:Tex_CompileRule_dvi = 'pdflatex --interaction=nonstopmode $*'
let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
let g:Tex_CompileRule_pdf = 'ps2pdf $*.ps'
" This is for spell check in tex file
autocmd filetype tex map <silent> <F5> :set spell!:echo "Spell check: " . strpart("OffOn", 3 * &spell, 3)
" Hotkey to view compiled pdf
autocmd filetype tex map <silent> <F9> \ll:!echo % \| awk -F "." '{print $1".pdf"}' \| xargs evince

" *** python with virtualenv support ***
" py << EOF
" import os
" import sys
" if 'VIRTUAL_ENV' in os.environ:
"   project_base_dir = os.environ['VIRTUAL_ENV']
"   activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"   execfile(activate_this, dict(__file__=activate_this))
" EOF

" let python_highlight_all=1

" *** my nmap ***
nmap <F8> :TagbarToggle<CR>
