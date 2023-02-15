#!/usr/bin/env bash

################################################################################
#                                                                              #
# Compiles a ".tex" file to PDF using pdflatex.                                #
#                                                                              #
# The compiled PDF is placed in the same directory as the source file.         #
#                                                                              #
################################################################################

if [[ $# -ne 1 ]]
then
    >&2 echo "illegal number of parameters"
    exit 1
fi

file_path=$1
file_name=$(basename $file_path)
file_name_wo_tex=$file_name
abs_file_path=$(readlink -f $file_path)
abs_file_dir=$(dirname $abs_file_path)

base_output_dir="/tmp/pdflatex_output"
output_dir=$base_output_dir$abs_file_dir
mkdir -p $output_dir

if [[ $file_name_wo_tex == *\.tex ]]
    then file_name_wo_tex=${file_name_wo_tex%.tex}
fi

pdflatex -output-directory=$output_dir $file_name

mv $output_dir/$file_name_wo_tex.pdf .
