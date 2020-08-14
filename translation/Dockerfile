FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04
WORKDIR /research
RUN apt-get update
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    build-essential \
    git \
    python \
    python-pip
ENV HOME /research
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
RUN apt-get install -y python-setuptools
RUN apt-get install -y python-pip python3-pip virtualenv htop
RUN pip3 install --upgrade numpy==1.14.2 scipy==1.0.1 sklearn==0.0 tensorflow-gpu==1.9.0

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Mount data into the docker
ADD . /research/transformer
WORKDIR /research/transformer
RUN pip3 install absl-py==0.2.0 \
    astor==0.6.2 \
    bleach==1.5.0 \
    cachetools==2.0.1 \
    certifi==2018.4.16 \
    chardet==3.0.4 \
    gast==0.2.0 \
    google-api-core==1.1.1 \
    google-auth==1.4.1 \
    google-cloud-bigquery==1.1.0 \
    google-cloud-core==0.28.1 \
    google-resumable-media==0.3.1 \
    googleapis-common-protos==1.5.3 \
    grpcio==1.11.0 \
    html5lib==0.9999999 \
    idna==2.6 \
    Markdown==2.6.11 \
    numpy==1.14.2 \
    protobuf==3.6.0 \
    psutil==5.4.5 \
    py-cpuinfo==4.0.0 \
    pyasn1==0.4.2 \
    pyasn1-modules==0.2.1 \
    pytz==2018.4 \
    requests==2.18.4 \
    rsa==3.4.2 \
    scikit-learn==0.19.1 \
    scipy==1.0.1 \
    six==1.11.0 \
    sklearn==0.0 \
    tb-nightly==1.8.0a20180420 \
    termcolor==1.1.0 \
    urllib3==1.22 \
    virtualenv==15.0.1 \
    Werkzeug==0.14.1
ENTRYPOINT ["/bin/bash"]

LABEL ai.backend.kernelspec="1" \
      ai.backend.envs.corecount="OPENBLAS_NUM_THREADS,OMP_NUM_THREADS,NPROC" \
      ai.backend.features="batch query uid-match user-input" \
      ai.backend.base-distro="ubuntu16.04" \
      ai.backend.resource.min.cpu="1" \
      ai.backend.resource.min.mem="1g" \
      ai.backend.runtime-type="python" \
      ai.backend.runtime-path="/usr/local/bin/python" \
      ai.backend.service-ports="ipython:pty:3000,jupyter:http:8080,jupyterlab:http:8090"