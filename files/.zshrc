
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# +-------------------------------------------------------------------------+ #
# |                                                                         | #
# |                    zsh configurations (".zshrc")                        | #
# |                                                                         | #
# |   My zsh configs.                                                       | #
# |                                                                         | #
# |   Author:               Nicola Bruhin                                   | #
# |   Last Changed:         19.05.2022                                      | #
# |                                                                         | #
# +-------------------------------------------------------------------------+ #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


# =============================== #
# ======= GENERAL CONFIGS ======= #
# =============================== #


DOTFILES_DIR=$HOME/.dotfiles


# ======================= #
# ======= VISUALS ======= #
# ======================= #


# ------- Prompt Configs ------- #

# The prompt style and the toggle are adapted from the Kali Linux ".zshrc".
#
# Press $TOGGLE_KEY to toggle the prompt style. There are 2 styles at the
# moment: "oneline" and "twoline". "twoline" is a prettified 2-line prompt
# while "oneline" is a simpler, more compact 1-line prompt. The default prompt
# style can be set with $DEFAULT_PROMPT.

DEFAULT_PROMPT=twoline           # the default style of the prompt ("oneline" or "twoline")
TOGGLE_KEY=^P # = "ctrl + p"     # key to toggle prompt style

# TODO: This needs some refactoring really badly
# TODO: "-" should not be printed for "oneline" style if there is no virtual
#       environment present
configure_prompt() {
    prompt_symbol="@"
    case "$DEFAULT_PROMPT" in
        twoline)
            PROMPT=$'%F{%(#.blue.green)}┌──${VIRTUAL_ENV:+[$(basename $VIRTUAL_ENV)]─}(%B%F{%(#.red.blue)}%n$prompt_symbol%m%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]\n└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '
            RPROMPT=$'%(?.. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.)'
            ;;
        oneline)
		PROMPT=$'%F{%(#.blue.green)}${VIRTUAL_ENV:+[$(basename $VIRTUAL_ENV)]}%F{reset}-%B%F{%(#.red.blue)}%n@%m%b%F{reset}:%B%F{%(#.blue.green)}%~%b%F{reset}%F{%(#.blue.blue)}%(#.#.$)%F{reset} '
            RPROMPT=
            ;;
    esac
}

# set the prompt to the default prompt
configure_prompt

# function to toggle prompt style
toggle_oneline_prompt(){
    if [ "$DEFAULT_PROMPT" = oneline ]; then
        DEFAULT_PROMPT=twoline
    else
        DEFAULT_PROMPT=oneline
    fi
    configure_prompt
    zle reset-prompt
}
zle -N toggle_oneline_prompt

# bind $TOGGLE_KEY to change prompt style
bindkey $TOGGLE_KEY toggle_oneline_prompt

# Print the prompt
precmd() {
    # Print the previously configured title
    print -Pnr -- "$TERM_TITLE"

    # Print a new line before the prompt, but only if it is not the first line
    if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
        _NEW_LINE_BEFORE_PROMPT=1
    else
        print ""
    fi
}

# ------- Terminal Style ------- #
#
# Use a base16 style
# TODO: write better documentation

BASE16_SHELL=$DOTFILES_DIR/"dependencies/base16-shell"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
	base16_tomorrow-night-eighties


# ================================== #
# ======= FUNCTIONAL CONFIGS ======= #
# ================================== #


# ------- Functions ------- #

# cd + ls
function cdls() {
    cd $@ && ls
}

# cd + la
function cdla() {
    cd $1 && la
}

# ------- Aliases ------- #

# ls
alias ls="ls --color=auto"      # enable color support for ls
alias l="ls"                    # shorthand for ls
alias sl="ls"                   # also work in case of typo
alias la="ls -lA"               # shorthand for ls -lA

# clear
alias cls="clear"               # alternative for clear
alias c="clear"                 # alternative for clear

# cdls
alias cl="cdls"

#cdla
alias ca="cdla"

# ------- History Configs ------- #

HISTFILE=~/.history
HISTSIZE=1000
SAVEHIST=2000
setopt HIST_IGNORE_ALL_DUPS     # don't save ANY duplicates in history
setopt HIST_IGNORE_SPACE        # don't save commands starting with a space in history
setopt HIST_REDUCE_BLANKS       # remove suprefluous blanks before writing to history
setopt SHARE_HISTORY            # share history between all sessions

# ------- Miscellaneous Settings ------ #

setopt NOTIFY              # report the status of background jobs immediately
setopt PROMPTSUBST         # enable command substitution in prompt
