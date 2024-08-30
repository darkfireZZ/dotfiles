
export EDITOR=nvim
export VISUAL=$EDITOR

export PAGER="bat --plain"

# Personal scripts to PATH
export PATH=$PATH:~/.dotfiles/scripts
# Manually installed binaries
export PATH=$PATH:~/.bin
# Programs installed using cargo
export PATH=$PATH:~/.cargo/bin

. ~/.bashrc
