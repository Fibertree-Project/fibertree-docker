Fibertree Notebooks
===================

Fibertree Jupyter notebooks in a docker container

Start the container
-----------------

- Put docker-compose.yaml in an otherwise empty directory
- Cd to the directory containing the docker-compose.yaml file
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

```
      % git clone https://mit.github.edu/symphony/fibertree-docker
      % cd fibertree-docker
      % make build [ALTTAG=test] [BUILD_FLAGS="<Docker build flags, e.g., --no-cache>"]
```
