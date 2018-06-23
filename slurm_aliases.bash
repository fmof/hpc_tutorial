export SQUEUE_FORMAT="%.7i %.9P %.8j %.8u %.2t %.10M %.6D %7q %R"

### get one CPU on one node, with 6GB vMem
alias sinteract='srun --partition=batch --mem=6000 -c1 -N1 --pty --preserve-env $SHELL'

### get two GPUs with 20GB vMem total
alias gpu-interact='srun --partition=gpu --mem=20000 --nodes=1 -c1 --gres=gpu:2 --pty --preserve-env $SHELL'

### show the jobs you have submitted
alias my-jobs='squeue -u `whoami` -o "%.18i %.9P %.j %.2t %.6b %.10M %R %.6D %.C %.J %.L" | column -t'

### usage: show the currently submitted jobs of
### a particular given user
function jobs-of() {
    squeue -u $1 -o "%.18i %.9P %.j %.2t %.6b %.10M %R %.6D %.C %.J %.L" | column -t
}

### show characteristics of a particular job (by job ID)
function describe-job() {
    squeue -j $1 -o "%.18i %.9P %.j %.2t %.10M %R %.6D %.C %.J %.L" | column -t
}

### show all submitted jobs
### this is useful for seeing what jobs are on what nodes
function show-jobs() {
    squeue -o "%.18i %8u %.12a %.9P %.10j %.6b %.2t %.10M %R %.6D %.C %.J %.L" | column -t
}

### show all nodes, one per line
alias list-nodes='sinfo -e -o "%.5o %.5D %.9P %.11T %.13C %.6G %.8z %.6m %.8d %.20f %.20E"'

### show nodes that have GPUs
function list-gpu() {
    if [[ -z "$1" ]]; then
	list-nodes | grep gpu
    else
	list-nodes | grep gpu | grep "$1"
    fi
}

### show nodes, according to partitions
alias list-parts='sinfo -e -o "%.25N %.5D %.9P %.11T %.13C %.6G %.8z %.6m %.8d %.20f %.20E"'
