#!/bin/bash -l
#SBATCH -J pipeline
#SBATCH -o pipeline_%j.out
#SBATCH -e pipeline_%j.err
#SBATCH -n 1

# ======================================
# Configure the experiment here:
#CONFIG='config/Oracle/config.json'
# CONFIG='/content/drive/MyDrive/Region-under-discussion-for-visual-dialog/QCS/config/Oracle/config-Sp-F.json'
CONFIG='/content/drive/MyDrive/Region-under-discussion-for-visual-dialog/QCS/config/Oracle/config-baseline.json'
DATA='/content/drive/MyDrive/Region-under-discussion-for-visual-dialog/QCS/data'
EXP_NAME='full'
BIN_NAME='full'
GPU_ID='1'
SPLIT='val'
# ======================================

export CUDA_VISIBLE_DEVICES=$GPU_ID
export LD_LIBRARY_PATH=/opt/cuda/10.1/lib64:/opt/cudnn/v7.6-cu10.0
export LC_ALL=
python -m train.Oracle.train \
	-data_dir $DATA \
    -config $CONFIG \
    -exp_name $EXP_NAME \
    -img_feat 'rss' \
    -bin_name $BIN_NAME &&

# MODEL_BIN=$(ls bin/Oracle | grep -i "$BIN_NAME" | tail -1)
MODEL_BIN = testing1
export CUDA_VISIBLE_DEVICES='-1'
python -m utils.misunderstandings \
	-data_dir $DATA \
    -config $CONFIG \
    -split $SPLIT \
    -out_fname /content/drive/MyDrive/Region-under-discussion-for-visual-dialog/QCS/mu-$SPLIT-$MODEL_BIN.json \
    -img_feat rss \
    -bin_path /content/drive/MyDrive/Region-under-discussion-for-visual-dialog/QCS/bin/Oracle/$MODEL_BIN &&

echo "-----------------------------"
echo "Performance"
python -m analysis.compute_accuracy --file /content/drive/MyDrive/Region-under-discussion-for-visual-dialog/QCS/mu-$SPLIT-$MODEL_BIN.json --hist -1 --numq --noloctype
echo "-----------------------------"
echo "Performance with history"
python -m analysis.compute_accuracy --file /content/drive/MyDrive/Region-under-discussion-for-visual-dialog/QCS/mu-$SPLIT-$MODEL_BIN.json --hist 1 --numq --noloctype
echo "-----------------------------"
echo "Performance without history"
python -m analysis.compute_accuracy --file /content/drive/MyDrive/Region-under-discussion-for-visual-dialog/QCS/mu-$SPLIT-$MODEL_BIN.json --hist 0 --numq --noloctype
