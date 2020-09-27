FROM jupyter/minimal-notebook:latest

LABEL maintainer="emer@csail.mit.edu"

# Arguments
ARG BUILD_DATE
ARG VCS_REF
ARG BUILD_VERSION


# Labels
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.name="jsemer/fibertree-docker"
LABEL org.label-schema.description="Fibertree jupyter notebook"
LABEL org.label-schema.url="http://people.csail.mit.edu/emer/"
LABEL org.label-schema.vcs-url="https://github.mit.edu/sysmphony/fibertree-docker"
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.vendor="Emer"
LABEL org.label-schema.version=$BUILD_VERSION
LABEL org.label-schema.docker.cmd="docker run -p 8888:8888 jsemer/fibertree-notebook"

ENV BIN_DIR=/usr/local/bin
ENV BUILD_DIR=/usr/local/src
ENV SHARE_DIR=/usr/local/share

USER root

COPY src/fiber-tree/examples/ipython /home/jovyan/fibertree-notebooks
COPY src/fiber-tree/examples/data /home/jovyan/data
COPY src/fiber-tree /home/jovyan/src/fiber-tree

RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
               libgl1 \
               fonts-freefont-ttf \
               ttf-dejavu-core \
    && cd /home/${NB_USER}/src/fiber-tree \
    && pip install --no-cache-dir -r requirements.txt \
    && fix-permissions "/home/${NB_USER}" \
    && fix-permissions "${CONDA_DIR}"  \
    && chown -R ${NB_USER} "/home/${NB_USER}"



USER $NB_UID

RUN cd /home/${NB_USER}/src/fiber-tree \
    && pip install -e . 

