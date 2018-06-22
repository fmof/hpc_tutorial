#!/bin/bash
#SBATCH --partition=batch
#SBATCH --mem=2000
#SBATCH -N1
#SBATCH -c1
#SBATCH --qos=normal
#SBATCH --time=10:00
#SBATCH --workdir=/umbc/xfs1/ferraro/users/ferraro_user

### exit on error
set -e
### make evaluating unset variables an error
set -o nounset

### set up the environment
module use ~/ferraro_common/module_files
module load conda/2.7

### get the file
file_index=${SLURM_ARRAY_TASK_ID} ## 0-indexed files
input_directory=/umbc/xfs1/ferraro/common/data/cac/cawiki-en.text_pos
input_file=${input_directory}/cawiki-en.${file_index}text_pos.tsv.gz
### in production, you may want to add
### error checking to see if the file exists

POS_COLUMN=2
script_file=${HOME}/code/hpc-tutorial/src/word_count.py

### run it
python ${script_file} \
       --compressed \
       --col ${POS_COLUMN} \
       "${input_file}"
