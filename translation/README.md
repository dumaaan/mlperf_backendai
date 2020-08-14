# MLPerf @ Backend.AI
A repo for the current MLperf implementation at [Backend.AI](https://github.com/lablup/backend.ai). This repo is created for tracking the progress and issues related with implementing MLPerf on Backend.AI

# **Translation Task for MLPerf on Backend AI**

Currently focusing on the Translation task. This benchmark can be higher variance than expected. This implementation and results are still preliminary, modifications may be made in the near future.

**Recommended environment:** Ubuntu 16.04 (16 CPUs, one P100, 100 GB disk)

**Model:** Transformer model based on the paper ["Attention Is All You Need"](https://papers.nips.cc/paper/7181-attention-is-all-you-need.pdf).

**Dataset:** WMT17 English:uk:-German:de: translation task dataset from [here](http://statmt.org/wmt17/translation-task.html).

**Data preprocessing:** done through Byte-Pair encoding, also known as [BPE](https://en.wikipedia.org/wiki/Byte_pair_encoding).


# More about the model

## Structure

Transformer is an Attention-based mechanism which features both encoder and decoder. Since it learns dependencies on all tokens, it can capture relatiosnhips in really long sentences and passages.
You can read more about them here:
- [Transformer](http://jalammar.github.io/illustrated-transformer/)
- [Attention mechanism - an example of neural translation](https://jalammar.github.io/visualizing-neural-machine-translation-mechanics-of-seq2seq-models-with-attention/)

## Weight & Bias initialization

- Embeddings: TensorFlow's random uniform initializer - [documentation](https://www.tensorflow.org/api_docs/python/tf/random_uniform_initializer)
- Transformer network: TensorFlow's variance initializer.

## Loss Function

Cross entropy loss. Note that padding is not considered part of loss.

## Quality Metric

BLEU scores.

## Target Quality

25 BLEU for uncased. Evaluation uses all of `newstest2014.en` file.


# Implementation

1. Download the dataset using `bash download_data.sh` command.
2. Prepare the Backend.AI-aware image and push it to Harbor. <- **TODO**
3. Run using `bash run_and_time.sh` script.
