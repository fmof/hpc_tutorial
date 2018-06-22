#!/bin/bash

### exit on error
set -e
### make evaluating unset variables an error
set -o nounset

### set up the environment
module use ~/ferraro_common/module_files
module load conda/2.7

### get the file
input_file=~/ferraro_common/data/cac/cawiki-en.text_pos/cawiki-en.0text_pos.tsv.gz
### in production, you may want to add
### error checking to see if the file exists

POS_COLUMN=2
script_file=${HOME}/code/hpc-tutorial/src/word_count.py

### run it
python ${script_file} \
       --compressed \
       --col ${POS_COLUMN} \
       "${input_file}"
