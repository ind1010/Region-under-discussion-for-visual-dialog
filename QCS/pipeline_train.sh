#!/bin/bash -l
#SBATCH -J pipeline
#SBATCH -o pipeline_%j.out
#SBATCH -e pipeline_%j.err
#SBATCH -n 1

# ======================================
# Configure the experiment here:
CONFIG='pathway/to/QCS/directory/config/Oracle/the_config_file_you_want.json'
DATA='pathway/to/QCS/directory/data'
EXP_NAME='choose an experiment name'
BIN_NAME='fill in the folder name'
GPU_ID='1'
SPLIT='test'
# ======================================

export CUDA_VISIBLE_DEVICES=$GPU_ID
export LD_LIBRARY_PATH=/opt/cuda/10.1/lib64:/opt/cudnn/v7.6-cu10.0
export LC_ALL=
python -m train.Oracle.train \
	-data_dir $DATA \
    -config $CONFIG \
    -exp_name $EXP_NAME \
    -img_feat 'rss' \
    -bin_name $BIN_NAME \
    -last_epoch put_last_epoch_number \
    -last_checkpoint put_last_checkpoint_file_name
