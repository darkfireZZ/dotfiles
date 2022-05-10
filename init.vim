" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
" +-------------------------------------------------------------------------+ "
" |                                                                         | "
" |                     My "init.vim" / ".vimrc" file                       | "
" |                                                                         | "
" |  Doesn't contain anything too spectacular...                            | "
" |                                                                         | "
" |  IMPORTANT: Dependencies & Requirements                                 | "
" |   - neovim 0.2.2 or newer (check with ":echo has('nvim-0.2.2')")        | "
" |   - python3 (check with ":echo has('python3')")                         | "
" |   - rls (only for rust suggestions)                                     | "
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
Plug 'ncm2/ncm2'
" requirement of ncm2
Plug 'roxma/nvim-yarp'

" This comes from ncm2, I have no clue what it actually does, but apparently it
" is important.
set completeopt=noinsert,menuone,noselect

" suggestions from current buffer
Plug 'ncm2/ncm2-bufword'
" path suggestions
Plug 'ncm2/ncm2-path'

" <------- Language Client -------> "

" plugin installation
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ }

" <------- Color Scheme -------> "

" Install color scheme. Configuration is done later on.
Plug 'chriskempson/base16-vim'

call plug#end()


" <------- Color Scheme Config -------> "

" set color scheme
colorscheme base16-default-dark

" The color scheme only works with this line for me, don't know why though.
"
" See https://github.com/chriskempson/base16-vim/#troubleshooting (last
" accessed 10.05.2022 13:22).
set termguicolors

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()


" ==================================== "
"        Miscellaneous Settings        "
" ==================================== "

" relative line numbers
set relativenumber
