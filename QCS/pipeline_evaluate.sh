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
BIN_NAME='fill in a directory name'
GPU_ID='1'
SPLIT='test'
# ======================================

export CUDA_VISIBLE_DEVICES=$GPU_ID
export LD_LIBRARY_PATH=/opt/cuda/10.1/lib64:/opt/cudnn/v7.6-cu10.0
export LC_ALL=

MODEL_BIN='fill in a directory name'
export CUDA_VISIBLE_DEVICES='-1'
python -m utils.misunderstandings \
	-data_dir $DATA \
    -config $CONFIG \
    -split $SPLIT \
    -out_fname pathway/to/QCS/directory/mu-$SPLIT-$MODEL_BIN.json \
    -img_feat rss \
    -bin_path pathway/to/QCS/directory/bin/Oracle/$MODEL_BIN/put_checkpoint_file_name &&

echo "-----------------------------"
echo "Performance"
python -m analysis.compute_accuracy --file pathway/to/QCS/directory/mu-$SPLIT-$MODEL_BIN.json --hist -1 --numq --noloctype
echo "-----------------------------"
echo "Performance with history"
python -m analysis.compute_accuracy --file pathway/to/QCS/directory/mu-$SPLIT-$MODEL_BIN.json --hist 1 --numq --noloctype
echo "-----------------------------"
echo "Performance without history"
python -m analysis.compute_accuracy --file pathway/to/QCS/directory/mu-$SPLIT-$MODEL_BIN.json --hist 0 --numq --noloctype
