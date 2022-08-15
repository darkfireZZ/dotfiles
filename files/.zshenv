
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# +-------------------------------------------------------------------------+ #
# |                                                                         | #
# |                        ".zshenv" config file                            | #
# |                                                                         | #
# |    Contains configs related to the $EDITOR and $PATH variables.         | #
# |                                                                         | #
# |    Author:          Nicola Bruhin                                       | #
# |    Last Changed:    15.08.2022                                          | #
# |                                                                         | #
# +-------------------------------------------------------------------------+ #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


# ------- EDITOR & VISUAL ------- #

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

# set $VISUAL to the same editor as $EDITOR
export VISUAL=$EDITOR

# ------- PAGER	------- #

# Set the PAGER environment variable
# Set to the first pager in the following list that is installed on the system
#  - less
#  - more
#  Print an error message if none of the pagers is found.
if type "less" > /dev/null; then
  export PAGER=less
elif type "more" > /dev/null; then
  export PAGER=more
else
  echo "ERROR (from $0): Found none of the following pagers: less, more" 1>&2
fi

# ------- PATH ------- #

# add rust's cargo directory to PATH if the directory exists
cargo_dir="$HOME/.cargo/env"
if [ -d "$cargo_dir" ]; then
    . $cargo_dir
fi
