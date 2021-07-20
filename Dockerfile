#
# Base image for release (mainly adding s6)
#
FROM jupyter/minimal-notebook:latest AS release-base

#
# Set version for s6 overlay
#
ARG OVERLAY_VERSION="v2.1.0.2"
ARG OVERLAY_ARCH="amd64"

#
# Add s6 overlay
#
USER root

RUN echo "**** install apt-utils and locales ****" && \
    apt-get update && \
    apt-get install -y \
            apt-utils \
            locales && \
    echo "**** install packages ****" && \
    apt-get install -y \
            curl \
            tzdata && \
    echo "**** generate locale ****" && \
    locale-gen en_US.UTF-8 && \
    echo "**** install application-required packages ****"&& \
    apt-get install -y --no-install-recommends \
               libgl1 \
               fonts-freefont-ttf \
               ttf-dejavu-core && \
    echo "**** cleanup ****" && \
    apt-get clean && \
    rm -rf \
       /tmp/* \
       /var/lib/apt/lists/* \
       /var/tmp/*

ADD https://github.com/just-containers/s6-overlay/releases/download/${OVERLAY_VERSION}/s6-overlay-${OVERLAY_ARCH}-installer /tmp/

RUN chmod +x /tmp/s6-overlay-${OVERLAY_ARCH}-installer && \
    /tmp/s6-overlay-${OVERLAY_ARCH}-installer / && \
    rm /tmp/s6-overlay-${OVERLAY_ARCH}-installer

#
# Create container with required packages
#
FROM release-base as release-with-packages

USER root

RUN echo "**** install required packages ****" && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
               libgl1 \
               fonts-freefont-ttf \
               ttf-dejavu-core && \
    echo "**** cleanup ****" && \
    apt-get clean && \
    rm -rf \
       /tmp/* \
       /var/lib/apt/lists/*

COPY /src/fibertree/requirements.txt /tmp

RUN pip install --no-cache-dir -r /tmp/requirements.txt

RUN fix-permissions "${CONDA_DIR}"


FROM release-with-packages as release

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
ENV SRC_DIR=/usr/local/src
ENV ETC_DIR=/usr/local/etc
ENV SHARE_DIR=/usr/local/share

ENV BUILD_DIR=/usr/local/src

#
# Install notebook extension
#
USER root
RUN pip install --no-cache  jupyter_nbextensions_configurator && \
    pip install git+https://github.com/NII-cloud-operation/Jupyter-LC_index

USER $NB_USER

RUN jupyter nbextensions_configurator enable --user && \
    jupyter nbextension install --py --user notebook_index && \
    jupyter nbextension enable --py --user notebook_index
#
# Get base and tools built in other containers
#
USER root

COPY /root /

#
# User data and installation
#
USER $NB_USER

COPY /src/fibertree-notebooks /home/${NB_USER}/fibertree-notebooks
COPY /src/fibertree /home/${NB_USER}/src/fibertree

USER root

RUN  fix-permissions "/home/${NB_USER}"

USER $NB_USER

RUN cd /home/${NB_USER}/src/fibertree \
    && pip install -e .

# Install the compiler if possible

COPY /src/hfa-compiler /home/${NB_USER}/src/hfa-compiler

USER root

RUN fix-permissions "/home/${NB_USER}"

USER $NB_USER

RUN [ -e "/home/${NB_USER}/src/hfa-compiler/setup.py" ] \
    && cd /home/${NB_USER}/src/hfa-compiler \
    && pip install -e . \
    || echo "No compiler to install"


#
# Create documentation
#
RUN pip install pdoc3 && \
    pdoc3 --html --output /home/${NB_USER}/doc fibertree.core && \
    pdoc3 --html --output /home/${NB_USER}/doc fibertree.graphics
#
# Launch application
#
USER root

ENTRYPOINT [ "/init" ]
