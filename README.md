# MLPerf @ Backend.AI
A repo for the current MLperf implementation at [Backend.AI](https://github.com/lablup/backend.ai). This repo is created for tracking the progress and issues related with implementing MLPerf on Backend.AI

# **Object Detection Task for MLPerf on Backend AI**

Currently focusing on the Object Detection task. 

**Metrics:** mask and box mAP.

**Dataset:** COCO dataset by Microsoft

**Data preprocessing limitations:** only horizontal flips allowed.

**Train and test data:** as provided by COCO dataset.

**Model:** Mask R-CNN with a ResNet50.

**Optimizer:** Momentum SGD. Weight decay of 0.0001, momentum of 0.9.

Layers are displayed when running `run_and_time.sh` script.

**Target metrics:** Box mAP of 0.377, mask mAP of 0.339


# **Current issues:**


1. Unable to run `docker` command - needs to rewrite the Dockerfile to reflect on Backend.AI specifics - **IN PROGRESS** - ideally it should be automated.
2. Needs to set up a proper configuration, including the information on current running GPU. - **8 NVIDIA V100 GPUs**.
3. To Be Continued


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
4. Ideally, you should be able to run `bash run_and_time.sh` script, but most likely, the script contents need an overhaul as well. **IN PROGRESS**




