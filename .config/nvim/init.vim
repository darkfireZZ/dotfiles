" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
" +-------------------------------------------------------------------------+ "
" |                                                                         | "
" |                     My "init.vim" / ".vimrc" file                       | "
" |                                                                         | "
" +-------------------------------------------------------------------------+ "
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ===================== "
"        Plugins        "
" ===================== "

call plug#begin()

" <------- NCM2 -------> "

" neovim completion manager
"Plug 'ncm2/ncm2'
" requirement of ncm2
"Plug 'roxma/nvim-yarp'

" This comes from ncm2, I have no clue what it actually does, but apparently it
" is important.
set completeopt=noinsert,menuone,noselect

" suggestions from current buffer
"Plug 'ncm2/ncm2-bufword'
" path suggestions
"Plug 'ncm2/ncm2-path'

" <------- UltiSnips -------> "
"Plug 'sirver/ultisnips'
"let g:UltiSnipsExpandTrigger = '<tab>'
"let g:UltiSnipsJumpForwardTrigger = '<tab>'
"let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" <------- Color Scheme -------> "

" Install color scheme. Configuration is done later on.
Plug 'chriskempson/base16-vim'

call plug#end()

" <------- Color Scheme Config -------> "

" set color scheme
colorscheme base16-tomorrow-night-eighties

" The color scheme only works with this line for me, don't know why though.
"
" See https://github.com/chriskempson/base16-vim/#troubleshooting (last
" accessed 10.05.2022 13:22).
set termguicolors

" enable ncm2 for all buffers
"autocmd BufEnter * call ncm2#enable_for_buffer()


" ==================================== "
"        Miscellaneous Settings        "
" ==================================== "

" filetype related stuff
filetype on             " enable filetype detection
filetype plugin on      " load file-specific plugins
filetype indent on      " load file-specific indentation

" absolute line number next to cursor
set number
" relative line numbers
set relativenumber

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert spaces
set expandtab
