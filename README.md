# MLPerf @ Backend.AI
A repo for the current MLperf implementation at [Backend.AI](https://github.com/lablup/backend.ai). This repo is created for tracking the progress and issues related with implementing MLPerf on Backend.AI

# Current implementations

1. Object Detection - Mask R-CNN with a ResNet50 - **IN PROGRESS**
2. Translation - GNMT - **TO DO**

Detailed information on each repo is for listed at each subdirectory.

# **Setup**

1. In the task directory, download the data using `bash download_dataset.sh` script. The time to download the dataset varies, depending on the task.
2. Run `bash verify_dataset.sh` script if there is any to check for the dataset integrity (optional).
3. Since running `docker` or `nvidia-docker` command is not possible in Backend.AI console due to concerns listed [here](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/). Therefore, you should create a separate Dockerfile featuring the requirements from the image listed in the problem's Dockerfile, and edit it so that it will be used as an image for Backend.AI platform. 
A good example would be to refer to Backend.AI kernels [here](https://github.com/lablup/backend.ai-kernels/blob/master/python-ff/Dockerfile.19.06-py36-cuda10). Please keep in mind that you should add labels specific to Backend.AI:
```
LABEL ai.backend.kernelspec="1" \
      ai.backend.envs.corecount="OPENBLAS_NUM_THREADS,OMP_NUM_THREADS,NPROC" \
      ai.backend.features="batch query uid-match user-input" \
      ai.backend.base-distro="ubuntu16.04" \
      ai.backend.resource.min.cpu="1" \
      ai.backend.resource.min.mem="1g" \
      ai.backend.runtime-type="python" \
      ai.backend.runtime-path="/usr/local/bin/python" \
      ai.backend.service-ports="ipython:pty:3000,jupyter:http:8080,jupyterlab:http:8090"
```
Currently, I have added a `add_label.py` python script to update labels in the Dockerfile, but it needs further testing and improvements.

The command to run the script is `python add_label.py <name/path to current Dockerfile> <new Dockerfile>`.

4. Ideally, you should be able to run `bash run_and_time.sh` script, but most likely, the script contents need an overhaul as well. **TO DO**

# Pushing the image to Backend.AI

1. Login through Docker to Harbor (https://beta.docker.backen.ai) using `docker login -u username SERVER` command.
2. Tag the image as the `beta.docker.backend.ai/mlperf/<your-image-name>`.
3. Push the image using `docker push <image tag>` command.

# TO DOs

1. Remake the Docker images to adapt them to Backend.AI platform - **TOP PRIORITY**
2. Automate the conversion of Docker images to Backend.AI platform


