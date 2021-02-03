Fibertree Notebooks
===================

Fibertree Jupyter notebooks in a docker container

Start the container
-----------------

- Copy **docker-compose.yaml.example** from this repo to **docker-compose.yaml** in an otherwise empty directory
- ```cd``` to the directory containing the **docker-compose.yaml** file
- Edit **docker-compose.yaml** and follow instructions in the file to customize to your environment
- Run the following command:
```
docker-compose up -d
```
- Browse over to localhost:8888

> :warning: **WARNING**: This docker compose file disables Jupyter tokens, so do not 
> use on a system exposed directly to the internet.

Refresh the container
----------------------

To update the Docker container run:

```
     % docker-compose pull
```


Build the container
--------------------

To build the container, first clone the repo (including the
submodules) and build using the **Makefile**.

```
      % git clone --recurse-submodules https://github.com/Fibertree-Project/fibertree-docker
      % cd fibertree-docker
      % make build [ALTTAG=test] [BUILD_FLAGS="<Docker build flags, e.g., --no-cache>"]
```

Note: the **Makefile** also supports pushing the container to hub.docker.com.

```
      % make push
```


Work on the fibertree repo
---------------------------

It takes a little work, but you can work on a clone of the original
fibertree git repo inside the docker container and then be able to
push your changes. Assuming you have followed the conventions in the
**docker-compile.yaml.example** file, you can do that as follows:

- Clone the fibertree git repo into the local directory containing the
  **docker-compose.yaml** file
```
    git clone git@github.com:Fibertree-project/fibertree.git fibertree-repo
```
- Mount the repo as a volume in your container by adding the following
  line to the **volumes:** section of your **docker-compose.yaml**
  file

```
 - ./fibertree-repo:/home/jovyan/fibertree-repo
```

- Start the container and enter a shell either from the Jupyter
  notebook or running:
```
    docker-compose exec notebook /bin/bash
```
- Then while in the container install the mounted version of the
  fibertree code:

```
    cd /home/jovyan/fibertree-repo
    pip install --user -e . 
```

- Edit the files in the fibertree repo (inside or outside the
container) and those changes will be reflected in your Jupyter
notebooks (after a kernel restart). You can then push those changes to
the fibertree repo...

-----------

Note 1: The above procedure will override the use of the internal copy
of the fibertree source code. You can restore that by getting into the
container and running the following:

```
    cd /home/jovyan/src/fibertree
    pip install --user -e .
```

------------

Note 2: If you already have cloned the fibertree-docker git repo and
recursively cloned the submodules there is a copy of the fibertree
repo in ./src/fibertree, so you can mount that as a volume in the
container if you like.
