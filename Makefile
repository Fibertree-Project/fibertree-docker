#
# Ultility Makefile to build/push Docker images
#
#
# To use an alternate tag invoke as:
#
#   make build ALTTAG=<alternate-tag>
#

VERSION := 0.1

USER    := jsemer
REPO    := fibertree-notebook

NAME    := ${USER}/${REPO}
GITTAG   := $$(git log -1 --pretty=%h)
IMG     := ${NAME}:${GITTAG}

ALTTAG  := latest
ALTIMG  := ${NAME}:${ALTTAG}

all:	build


# Build and tag docker image

build:
	./scripts/update_compiler_repo.sh
	docker build ${BUILD_FLAGS} \
          --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
          --build-arg VCS_REF=${TAG} \
          --build-arg BUILD_VERSION=${VERSION} \
          -t ${IMG} .
	docker tag ${IMG} ${ALTIMG}


# Push docker image

push:
	docker push ${NAME}


# Lint the Dockerfile

lint:
	docker run --rm -i hadolint/hadolint < Dockerfile || true

# Login to docker hub

login:
	@docker log -u ${DOCKER_USER} -p ${DOCKER_PASS}
