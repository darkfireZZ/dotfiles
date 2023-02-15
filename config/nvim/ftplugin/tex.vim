" Compile the current file to PDF using .dotfiles/scripts/compile-latex.sh
:map <Space>c :execute "!compile-latex.sh " .. expand("%:p")<Enter>

" Open the compiled PDF file
:map <Space>o :execute "!open " .. expand("%:r") .. ".pdf"<Enter><Enter>

" Compile the current file and open it
:map <Space>C <Space>c<Enter><Space>o
