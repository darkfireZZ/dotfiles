#/usr/bin/env bash

 #############################################################################
 #                                                                           #
 #                        build script for my dotfiles                       #
 #                                                                           #
 #  Sets up all the configs. Meaning all files are linked to the right       #
 #  places and dependencies are installed. I only tested this on Ubuntu      #
 #  and did not test it very well, so there will likely be a whole lot of    #
 #  bugs in here. If you spot one, tell me and I'll fix it.                  #
 #                                                                           #
 #  IMPORTANT: Before running this script, make sure that the following      #
 #             dependencies are installed:                                   #
 #               init.vim :                                                  #
 #                 - python3                                                 #
 #                 - curl                                                    #
 #                 - neovim 0.2.2 or newer                                   #
 #                 - rls (for rust suggestions)                              #
 #               kitty.conf :                                                #
 #                 - kitty                                                   #
 #               .zshenv :                                                   #
 #                 - zsh                                                     #
 #               .zshrc :                                                    #
 #                 - zsh                                                     #
 #                                                                           #
 # EVEN MORE IMPORTANT: This script is NOT WELL TESTED and might mess up     #
 #                      your system.                                         #
 #                                                                           #
 #  Author: Nicola Bruhin                                                    #
 #  Last Change: 13.08.2022                                                  #
 #                                                                           #
 #############################################################################


# ======= some setup ====== #

# rename the dotfiles directory to ".dotfiles"
old_dotfiles=$(realpath $(dirname $0))

# store the location of the dotfiles directory for easier access later on
dotfiles=$(dirname $old_dotfiles)/.dotfiles

if [ "$old_dotfiles" != "$dotfiles" ]; then
    mv $old_dotfiles $dotfiles
fi


# ======= link files ======= #

echo "Link files..."

ln -f $dotfiles/files/.zshrc $HOME/.zshrc
ln -f $dotfiles/files/.zshenv $HOME/.zshenv
ln -f $dotfiles/files/kitty.conf $HOME/.config/kitty/kitty.conf

# sometimes the nvim config directory does not exist, in that case, create it
if [ ! -d $HOME/.config/nvim ]; then
    mkdir $HOME/.config/nvim
fi
ln -f $dotfiles/files/init.vim $HOME/.config/nvim/init.vim


# ======= install dependencies ======= #

echo "Install dependencies..."
$dotfiles/scripts/install_dependencies.sh
