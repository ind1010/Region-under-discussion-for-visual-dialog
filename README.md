**OSCAR: Occluding Spatials, Category, And Region under discussion**

Authors: Indu Panigrahi and Raymond Liu

Included in this repository:
* ``QCS/`` - Contains the QCS+RuD model with our GRU implementation of the question embedding. The configurations for our ablation experiments on the input embedding are in ``configs/``. Note that we do not include the CMO model as we do not perform any experiments on it.
* ``train.ipynb`` - Contains code to run training and evaluation scripts
* Poster presented at the COS 484 Poster Session on 04/21/2022
* Submitted Project Report

# Region-under-discussion-for-visual-dialog

You should have available three things on the root directory for this repository:
1. QCS: directory with QCS code.
2. GWHist.csv: an annotated subset of history dependent questions.
3. README.md: this file.

In order to run these experiments you need the following data and features:

+ [GuessWhat?! dataset](https://drive.google.com/file/d/1JiJIV_Ve65SHriU8veTtLVWmlM-Nu6pi/view?usp=sharing)
+ MS COCO images ([train](images.cocodataset.org/zips/train2014.zip) and [validation](images.cocodataset.org/zips/val2014.zip) from 2014).
+ The [visual features](https://drive.google.com/file/d/1t1PoKWkrDoKlQwJehtG2mHiuJ5B9-Al2/view?usp=sharing) for the target objects

## QCS
To run experiments, edit the config/Oracle/config.json file or create one.

### Semantic parse
```
$ python3 -m scripts.parse
```

### Run experiment
Modify the run parameters in pipeline.sh

```
# ======================================
# Configure the experiment here:
CONFIG='config/Oracle/config.json'
EXP_NAME='Oracle_exp'
BIN_NAME='_experiment_'
GPU_ID='0'
SPLIT='test'
# ======================================
```
then run
```
$ sh pipeline.sh
```

## GWHist

Subset of history dependent questions of GuessWhat?!
The csv file contains the following data:

- question\_id: The unique identifier for the given question in the GuessWhat?! dataset.
- game\_id: Game ID of a given question.
- question: The history dependent question.

