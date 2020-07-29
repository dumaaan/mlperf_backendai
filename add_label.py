import shutil
import sys

def adapt(input_file, output_file):
    """
    Adds Backend.AI specific labels at the end of the Dockerfile, creating a new file named DockerfileNew.
    
    run in terminal as add_label.py [current Dockerfile] [new Dockerfile name]
    """
    code = '''\nLABEL ai.backend.kernelspec="1" \ \n
      ai.backend.envs.corecount="OPENBLAS_NUM_THREADS,OMP_NUM_THREADS,NPROC" \ \n
      ai.backend.features="batch query uid-match user-input" \ \n
      ai.backend.base-distro="ubuntu16.04" \ \n
      ai.backend.resource.min.cpu="1" \ \n
      ai.backend.resource.min.mem="1g" \ \n
      ai.backend.resource.min.cuda.device=0 \ \n
      ai.backend.resource.min.cuda.shares=0 \ \n
      ai.backend.runtime-type="python" \ \n
      ai.backend.runtime-path="/usr/bin/python3" \ \n
      ai.backend.service-ports="ipython:pty:3000,tensorboard:http:6006,jupyter:http:8080,jupyterlab:http:8090" \n
WORKDIR /home/work'''
    
    shutil.copy2(input_file, output_file)
    
    with open(output_file, 'a') as f:
        f.write(code)
        f.close()
    print("Converted successfully\n")

input_file = str(sys.argv[1])
output_file = str(sys.argv[2])
adapt(input_file, output_file)