FROM lablup/common-base:20.06-py36-cuda10.1

ENV PYTORCH_VERSION=1.0.1
ARG CUDA=10.0
ENV CUDNN_VERSION=7.6.4.38-1+cuda10.0
ENV PYTHONUNBUFFERED=1 \
    LD_LIBRARY_PATH="/usr/local/cuda/extras/CUPTI/lib64:/usr/local/cuda/lib64:/usr/local/nvidia/lib64:/usr/include/x86_64-linux-gnu" \
    PATH="/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bin/mecab" \
    LANG=C.UTF-8

SHELL ["/bin/bash", "-cu"]


FROM pytorch/pytorch:1.0.1-cuda10.0-cudnn7-devel
RUN apt-get update -y \
 && apt-get install -y apt-utils=1.2.29ubuntu0.1 \
                       libglib2.0-0=2.48.2-0ubuntu4.1 \
                       libsm6=2:1.2.2-1 \
                       libxext6=2:1.3.3-1 \
                       libxrender-dev=1:0.9.9-0ubuntu1

RUN git clone https://github.com/cocodataset/cocoapi.git \
 && cd cocoapi/PythonAPI \
 && git reset --hard ed842bffd41f6ff38707c4f0968d2cfd91088688 \
 && python setup.py build_ext install

RUN pip install ninja==1.8.2.post2 \
                yacs==0.1.5 \
                cython==0.29.5 \
                matplotlib==3.0.2 \
                opencv-python==4.0.0.21 \
                mlperf_compliance==0.0.10 \
                torchvision==0.2.2

FROM lablup/common-base:20.06-py36-cuda10.1

RUN python3 -m pip install pip --no-cache-dir \
        pandas==1.0.4 \
    	https://download.pytorch.org/whl/cu101/torch-${PYTORCH_VERSION}%2Bcu101-cp36-cp36m-linux_x86_64.whl \
        https://download.pytorch.org/whl/cu101/torchvision-${TORCHVISION_VERSION}%2Bcu101-cp36-cp36m-linux_x86_64.whl \
        https://download.pytorch.org/whl/torchaudio-${TORCHAUDIO_VERSION}-cp36-cp36m-linux_x86_64.whl \
        torchtext==${TORCHTEXT_VERSION}	     

# Install ipython kernelspec
RUN python3 -m ipykernel install --display-name "Lablup FF 20.06 on Python 3.6 (CUDA 10.1)" && \
    cat /usr/local/share/jupyter/kernels/python3/kernel.json

# Backend.AI specifics
LABEL ai.backend.kernelspec="1" \
      ai.backend.envs.corecount="OPENBLAS_NUM_THREADS,OMP_NUM_THREADS,NPROC" \
      ai.backend.features="batch query uid-match user-input" \
      ai.backend.base-distro="ubuntu16.04" \
      ai.backend.resource.min.cpu="1" \
      ai.backend.resource.min.mem="1g" \
      ai.backend.resource.min.cuda.device=0 \
      ai.backend.resource.min.cuda.shares=0 \
      ai.backend.runtime-type="python" \
      ai.backend.runtime-path="/usr/bin/python3" \
      ai.backend.service-ports="ipython:pty:3000,tensorboard:http:6006,jupyter:http:8080,jupyterlab:http:8090"

WORKDIR /home/work
# vim: ft=dockerfile

# For information purposes only, these are the versions of the packages which we've successfully used:
# $ pip list
# Package              Version           Location
# -------------------- ----------------- -------------------------------------------------
# backcall             0.1.0
# certifi              2018.11.29
# cffi                 1.11.5
# cycler               0.10.0
# Cython               0.29.5
# decorator            4.3.2
# fairseq              0.6.0             /scratch/fairseq
# ipython              7.2.0
# ipython-genutils     0.2.0
# jedi                 0.13.2
# kiwisolver           1.0.1
# maskrcnn-benchmark   0.1               /scratch/mlperf/training/object_detection/pytorch
# matplotlib           3.0.2
# mkl-fft              1.0.10
# mkl-random           1.0.2
# mlperf-compliance    0.0.10
# ninja                1.8.2.post2
# numpy                1.16.1
# opencv-python        4.0.0.21
# parso                0.3.2
# pexpect              4.6.0
# pickleshare          0.7.5
# Pillow               5.4.1
# pip                  19.0.1
# prompt-toolkit       2.0.8
# ptyprocess           0.6.0
# pycocotools          2.0
# pycparser            2.19
# Pygments             2.3.1
# pyparsing            2.3.1
# python-dateutil      2.8.0
# pytorch-quantization 0.2.1
# PyYAML               3.13
# setuptools           40.8.0
# six                  1.12.0
# torch                1.0.0.dev20190225
# torchvision          0.2.1
# tqdm                 4.31.1
# traitlets            4.3.2
# wcwidth              0.1.7
# wheel                0.32.3
# yacs                 0.1.5
