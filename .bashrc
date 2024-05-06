
if [[ $- == *i* ]]
then
    alias ls='eza'
    alias tree='eza --tree'

    alias proj="cd $HOME/proj"

    alias vim='nvim'

    # feh themes
    alias fehthumb="feh --theme thumb"

    BASE16_SHELL="$HOME/.config/base16-shell"
    if [[ -s "$BASE16_SHELL/profile_helper.sh" ]]
    then
        source "$BASE16_SHELL/profile_helper.sh"
    fi

    # TODO fix
    base16_tomorrow-night-eighties

    # set prompt with starship
    eval "$(starship init bash)"
fi
