This directory contains the configurations for:

* Baseline model: configs to train the baseline QCS+RuD model
* Ablations from the original paper: no2nd, noneg, and nosuper
* Our ablations on input embedding: We use a naming convention where Q = question embedding, I = image spatial, T = target category, and R = Region under discussion spatial. For example, ``config-qi.json`` contains the configs for the model with only the image spatial and question embedding included in the input embedding (i.e., target category and RuD are ablated).
* Question embeddings that we experimented with: the remaining config files
