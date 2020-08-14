#Object Detection related requirements
FROM lablup/python-pytorch:1.6-py36-cuda10.1
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# install basics
RUN apt-get update -y \
 && apt-get install -y apt-utils \
                       libglib2.0-0 \
                       libsm6=2:1.2.2-1 \
                       libxext6=2:1.3.3-1 \
                       libxrender-dev

RUN pip install ninja==1.8.2.post2 \
                yacs==0.1.5 \
                cython==0.29.5 \
                matplotlib==3.0.2 \
                opencv-python==4.0.0.21 \
                mlperf_compliance==0.0.10 \
                torchvision==0.2.2

# install pycocotools
RUN git clone https://github.com/cocodataset/cocoapi.git \
 && cd cocoapi/PythonAPI \
 && git reset --hard ed842bffd41f6ff38707c4f0968d2cfd91088688 \
 && python setup.py build_ext install

#Backend.AI specific labels
LABEL ai.backend.kernelspec="1" \
      ai.backend.envs.corecount="OPENBLAS_NUM_THREADS,OMP_NUM_THREADS,NPROC" \
      ai.backend.features="batch query uid-match user-input" \
      ai.backend.resource.min.cpu="1" \
      ai.backend.resource.min.mem="1" \
      ai.backend.accelerators="cuda" \
      ai.backend.resource.min.cuda.device="0" \
      ai.backend.resource.min.cuda.shares="0" \
      ai.backend.base-distro="ubuntu16.04" \
      ai.backend.runtime-type="python" \ 
      ai.backend.runtime-path="/usr/bin/python3" \
      ai.backend.service-ports="jupyter:http:8080,jupyterlab:http:8090,tensorboard:http:6006"