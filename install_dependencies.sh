#/usr/bin/env bash

 #############################################################################
 #                                                                           #
 #                 dependency install script for my dotfiles                 #
 #                                                                           #
 #  Download & install dependencies.                                         #
 #                                                                           #
 #  Author: Nicola Bruhin                                                    #
 #  Last Change: 19.05.2022                                                  #
 #                                                                           #
 #############################################################################

# Create a dependencies directory if it does not already exist
mkdir -p dependencies

# Check if git is installed, if it is not, print an error message and exit
git --version 2>&1 >/dev/null
GIT_IS_AVAILABLE=$?
if [ $GIT_IS_AVAILABLE -ne 0 ]; then
    echo "git is not installed" >&2
    echo "git is required for this script to work" >&2
    exit 1
fi

# Install base16-shell
echo "Installing chriskempson/base16-shell..." >&2
BASE16_SHELL_DIR="./dependencies/base16-shell"
if [ -d $BASE16_SHELL_DIR ]; then
    echo "base16-shell is already installed." >&2
    # TODO: Update base16-shell if it is already installed
else
    git clone https://github.com/chriskempson/base16-shell.git $BASE16_SHELL_DIR
fi

# Print nice finish message in the end
echo "All dependencies were successfully installed."
