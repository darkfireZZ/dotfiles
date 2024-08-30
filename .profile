
export EDITOR=nvim
export VISUAL=$EDITOR

export PAGER="bat --plain"

# Add personal scripts to PATH
export PATH=$PATH:~/.dotfiles/scripts

# Add programs installed via cargo to PATH
export PATH=$PATH:~/.cargo/bin

# Manually installed binaries
export PATH=$PATH:~/.bin

. ~/.bashrc
