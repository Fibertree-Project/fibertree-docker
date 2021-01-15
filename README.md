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
````


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
