
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# +-------------------------------------------------------------------------+ #
# |                                                                         | #
# |                        ".zshenv" config file                            | #
# |                                                                         | #
# |    Contains configs related to the $EDITOR and $PATH variables.         | #
# |                                                                         | #
# |    Author:          Nicola Bruhin                                       | #
# |    Last Changed:    18.04.2022                                          | #
# |                                                                         | #
# +-------------------------------------------------------------------------+ #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


# ------- EDITOR ------- #

# Set the EDITOR environment variable
# Set to the first editor in the following list that is installed on the system
#  - nvim
#  - vim
#  - nano
# Print an error message if none of the editors is found.
if type "nvim" > /dev/null; then
  export EDITOR=nvim
elif type "vim" > /dev/null; then
  export EDITOR=vim
elif type "nano" > /dev/null; then
  export EDITOR=nano
else
  echo "ERROR (from $0): Found none of the following editors: nvim, vim, \
nano" 1>&2
fi

# ------- PATH ------- #

# add rust's cargo directory to PATH
. "$HOME/.cargo/env"
