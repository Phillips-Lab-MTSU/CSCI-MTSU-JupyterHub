# CSCI-MTSU-JupyterHub

Docker container for CSCI @ MTSU (ver. 2023-08-14)

This container is built on top of jupyter/datascience-notebook provided by jupyter/docker-stacks. It provides a JupyterLab environment with several essential (and non-essential) tools used in CSCI courses.

**Only if you are running on Linux with an NVIDIA GPU**: You will also need to make sure your Docker installation is set up to use the Nvidia container toolkit, as described [here](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html), or just `sudo apt-get install nvidia-container-toolkit` if you are using NVIDIA/CUDA on your host.

### Running the container image...

The recommended way to obtain the docker image is to pull from DockerHub:
```
docker pull jlphillips/csci:2023-Fall
docker run -it --rm -p 8888:8888 --gpus all --user root -e JUPYTER_ENABLE_LAB=yes -e GRANT_SUDO=yes -v /home/jphillips:/home/jovyan/work jlphillips/csci:2023-Fall
```

**You will need to modify `/home/jphillips` to instead indicate where your files are located in order to make this work...**

### Building the container image...

If you want to build the image yourself (rather than pulling the image from DockerHub - note this is probably not what you want to do), you may do the following...

To prep:
```
git clone https://github.com/Phillips-Lab-MTSU/CSCI-MTSU-JupyterHub.git
```
 
To build:
```
docker build -t csci:2023-Fall CSCI-MTSU-JuptyerHub
```

To run:
```
docker run -it --rm -p 8888:8888 -- gpus all --user root -e JUPYTER_ENABLE_LAB=yes -e GRANT_SUDO=yes -v /home/jphillips:/home/jovyan/work csci:2023-Fall
```

