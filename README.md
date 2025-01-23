# CSCI-MTSU-JupyterHub

Docker container for CSCI @ MTSU (ver. 2025-01-13)

Source: [https://github.com/Phillips-Lab-MTSU/CSCI-MTSU-JupyterHub](https://github.com/Phillips-Lab-MTSU/CSCI-MTSU-JupyterHub)

This container is built on top of jupyter/datascience-notebook provided by jupyter/docker-stacks. It provides a JupyterLab environment with several essential (and non-essential) tools used in CSCI courses.

**Only if you are running on Linux with an NVIDIA GPU**: You will also need to make sure your Docker installation is set up to use the Nvidia container toolkit, as described [here](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html), or just `sudo apt-get install nvidia-container-toolkit` if you are using NVIDIA/CUDA on your host.

### Running the container image...

The recommended way to obtain the docker image is to pull from DockerHub:
```
docker pull jlphillips/csci:2025-Spring
docker run -it --rm -p 8888:8888 --gpus all --user root -e GRANT_SUDO=yes -v /home/jphillips:/home/jovyan/work jlphillips/csci:2025-Spring
```

**You will need to modify `/home/jphillips` to instead indicate where your files are located in order to make this work...**

**You may need to drop the `--gpus all` flag if you do not have any compatible GPU devices on your system...**

**If you are running on Linux, but your user id is *not* 1000 (typical, but not always), then you should add `-e NB_UID=${UID}` to your command...**

### Building the container image...

If you want to build the image yourself (rather than pulling the image from DockerHub - note this is probably not what you want to do), you may do the following...

To prep:
```
git clone https://github.com/Phillips-Lab-MTSU/CSCI-MTSU-JupyterHub.git
```
 
To build:
```
docker build -t csci:2025-Spring CSCI-MTSU-JuptyerHub
```

To run:
```
docker run -it --rm -p 8888:8888 -- gpus all --user root -e GRANT_SUDO=yes -v /home/jphillips:/home/jovyan/work csci:2025-Spring
```

### Converting to an apptainer image (sif format)

You can convert the stack to sif format for running with apptainer using apptainer ([https://apptainer.org/](https://apptainer.org/) itself:
```
apptainer build csci-2025-Spring.sif docker://jlphillips/csci:2025-Spring
```

If you have a local image instead (from building above, then you could connect to your local docker daemon instead):
```
apptainer build csci-2025-Spring.sif docker-daemon://csci:2025-Spring
```

### Running with apptainer

Once you have built the SIF, then you can run it with a command similar to this *from your home directory*:
```
mkdir jlab-workspace
apptainer run --bind /home/jphillips/jlab-workspace:/home/jovyan --env NB_UID=${UID} --writable-tmpfs csci-2025-Spring.sif
```
Note that apptainer will not allow `sudo` inside of the container because it runs in userspace and the image filesystem is *read-only*, however the `jlab-workspace` directory that is created above can be used to house temporary files (some are necessary for the container app to function), and any local packages that you want to install using `pip install --user` (they will persist across restarts in this directory). You can always remove the `jlab-workspace` directory or use any other directory of your choosing instead to make room for these files.


