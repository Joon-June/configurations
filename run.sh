#!/bin/bash


exp_name="EXP"
lr="0.001"
lr_decay_rate="0.5"
lr_decay_step_size="10"
batch_size="32"
num_epochs="30"
weight_decay="0.0"
dropout="0.3"
num_workers="10"
date="0402"
gpu="0, 1"
#seed="2424"

BASEDIR=$(dirname "$0")

train_script_path="${BASEDIR}/../source/train.py"
log_dir="${BASEDIR}/../log/${date}"
model_dir="${BASEDIR}/../models/${date}"

mkdir -p "${log_dir}"
mkdir -p "${model_dir}"

CMD="python -u ${train_script_path} "
OPTION=""
OPTION+="--exp_name ${exp_name} "
OPTION+="--lr ${lr} "
OPTION+="--lr_decay_rate ${lr_decay_rate} "
OPTION+="--lr_decay_step_size ${lr_decay_step_size} "
OPTION+="--batch_size ${batch_size} "
OPTION+="--num_epochs ${num_epochs} "
OPTION+="--weight_decay ${weight_decay} "
OPTION+="--dropout ${dropout} "
OPTION+="--num_workers ${num_workers} "
OPTION+="--parallel "
OPTION+="--save "
OPTION+="--date ${date} "
#OPTION+="--seed $seed "
OPTION+="--gpu ${gpu} "

CMD+=$OPTION

echo $CMD

SPECIFIER="${exp_name}_${date}_lr_${lr}_lr_decay_rate_${lr_decay_rate}_lr_decay_step_size_${lr_decay_step_size}_batch_size_${batch_size}_num_epochs_${num_epochs}_weight_decay_${weight_decay}_dropout_${dropout}.txt"
LOG_FILE="${log_dir}/${SPECIFIER}"

$CMD |& tee $LOG_FILE
