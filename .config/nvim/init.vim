

" <------- UltiSnips -------> "
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" <------- GitHub Copilot -------> "
let g:copilot_no_tab_map = v:true
imap <silent><script><expr> <C-Space> copilot#Accept("\<CR>")

" <------- Color Scheme Config -------> "

" set color scheme
colorscheme base16-tomorrow-night-eighties

" The color scheme only works with this line for me, don't know why though.
"
" See https://github.com/chriskempson/base16-vim/#troubleshooting (last
" accessed 10.05.2022 13:22).
set termguicolors

" ==================================== "
"        Miscellaneous Settings        "
" ==================================== "

" Set python3 provider. This is necessary for the provider to be available in
" virtual environments.
let g:python3_host_prog = '/usr/bin/python3'

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
