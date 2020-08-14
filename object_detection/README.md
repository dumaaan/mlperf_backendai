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


1. Unable to run `docker` command - needs to rewrite the Dockerfile to reflect on Backend.AI specifics - **Solved** - ideally it should be automated.
2. Needs to set up a proper configuration, including the information on current running GPU. - **8 NVIDIA V100 GPUs**.
3. There are four Dockerfiles within the Object Detection repo - need to figure out which ones to integrate.
4. Update the label adder script - still in the draft version.
5. Currently running `bash run_and_time.sh` gives `PermissionError: [Errno 13] Permission denied` error. Probably, there is a dependency/access issues. Needs further investigation. - **SOLVED** - [solution here](https://github.com/mlperf/training/issues/404)
