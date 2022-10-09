#!/usr/bin/env bash

if [[ $# -ne 2 ]]
then
    >&2 echo "illegal number of parameters"
    exit 1
fi

file_name=$1
template=$2

template_dir=$HOME/.dotfiles/templates
template_path=$template_dir/$template

if ! [[ -f "$template_path" ]]
then
    >&2 echo "template \"$template\" does not exist"
    exit 1
fi

cp $template_path $file_name
