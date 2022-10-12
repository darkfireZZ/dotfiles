#/usr/bin/env bash

 #############################################################################
 #                                                                           #
 #  Dependency install script for my dotfiles                                #
 #                                                                           #
 #############################################################################

# Store location of "dotfiles" directory
dotfiles_dir=$(basename $0)

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
BASE16_SHELL_DIR="$dotfiles_dir/dependencies/base16-shell"
if [ -d $BASE16_SHELL_DIR ]; then
    echo "base16-shell is already installed." >&2
    # TODO: Update base16-shell if it is already installed
else
    git clone https://github.com/chriskempson/base16-shell.git $BASE16_SHELL_DIR
fi

curl -o dependencies/up.sh https://raw.githubusercontent.com/shannonmoeller/up/master/up.sh

# Print nice finish message in the end
echo "All dependencies were successfully installed."
