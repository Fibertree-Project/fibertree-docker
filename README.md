Fibertree Notebooks
===================

Fibertree Jupyter notebooks in a docker container

Start the container
-----------------

- Copy **docker-compose.yaml.example** to **docker-compose.yaml** in an otherwise empty directory
- Cd to the directory containing the **docker-compose.yaml** file
- In **docker-compose.yaml**, change NB_UID to the uid of the user you want to own your notebooks 
- Run the following command:
```
        % docker-compose up -d
```
- Browse over to localhost:8888


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
      % git clone --recurse-submodules https://mit.github.edu/symphony/fibertree-docker
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

- Clone the fibertree git repo into a local directory

```
    cd ./data/fibertree
    git clone git@github.mit.edu:symphony/fiber-tree.git fibertree-repo

```
- Mount the repo as a volume in your container by adding the following
  line to the **volumes:** section of  your **docker-compose.yaml** file

```
 - ./data/fibertree/fibertree-repo:/home/jovyan/fibertree-repo
```

- Start the container and enter a shell either from the Jupyter
  notebook or running:
  
```
    docker-compile exec notebook /bin/bash
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
    cd /home/jovyan/src/fiber-tree
    pip install --user -e .
```

------------

Note 2: If you already have cloned the fibertree-docker git repo and
recursively cloned the submodules there is a copy of the fibertree
repo in ./src/fiber-tree, so you can mount that as a volume in the
container if you like.
