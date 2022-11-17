# PHONY are targets with no files to check, all in our case
.DEFAULT_GOAL := help

ORG=cadic
PACKAGE=whisper
IMAGE_VANILLA=$(ORG)/$(PACKAGE):vanilla
IMAGE_SANDBOX=$(ORG)/$(PACKAGE):sandbox
SRV=/srv
FILESTORE=/FileStore


# Ensure that we have a configuration file
# $(conf_file):
#         $(error Please create a '$(conf_file)' file first, for example by copying example_conf.env. No '$(conf_file)' found)

VERSION=$(shell python -c 'from $(PACKAGE) import __version__;print(__version__)')


# Makefile for launching common tasks
DOCKER_OPTS ?= \
    -e DISPLAY=$(DISPLAY) \
	-v /dev/shm:/dev/shm \
	-v $(HOME)/.ssh:/home/foo/.ssh \
	-v $(HOME)/.config:/home/foo/.config \
	-v $(PWD):/workspace \
	-v $(SRV):/srv \
	-v $(FILESTORE):/FileStore \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /var/run/docker.sock:/var/run/docker.sock \
	--network=host \
	--privileged


help:
	@echo "Usage: make {build,  bash, ...}"
	@echo "Please check README.md for instructions"
	@echo ""


# BUILD:
build: build_wheel build_dockers

# BUILD DOCKER
build_dockers: build_vanilla build_sandbox 

build_vanilla:
	docker build . -t  ${IMAGE_VANILLA} --network host -f docker/vanilla/Dockerfile

build_sandbox:
	@docker build . -t  $(IMAGE_SANDBOX) --network host \
		-f docker/sandbox/Dockerfile

# BUILD WHEEL
build_wheel:
	# Build the wheels
	@mv dist/$(PACKAGE)*.whl dist/legacy/ || true; \
		python setup.py bdist_wheel; clean || true
	
# PUSH
push: push_docker_vanilla push_docker_sandbox

push_docker_sandbox:
	@docker tag $(IMAGE_SANDBOX) $(IMAGE_SANDBOX)-$(PACKAGE)_$(VERSION)
	docker push $(IMAGE_SANDBOX)
	docker push $(IMAGE_SANDBOX)-$(PACKAGE)_$(VERSION)

push_docker_vanilla:
	@docker tag $(IMAGE_VANILLA) $(IMAGE_VANILLA)-$(PACKAGE)_$(VERSION)
	docker push $(IMAGE_VANILLA)
	docker push $(IMAGE_VANILLA)-$(PACKAGE)_$(VERSION)

# PULL
pull: pull_vanilla pull_sandbox

pull_vanilla:
	docker pull $(IMAGE_VANILLA)

pull_sandbox:
	docker pull $(IMAGE_SANDBOX)

# DOCKER RUNs
sandbox:
	@docker stop dev_$(PACKAGE)_sandbox || true
	@docker rm dev_$(PACKAGE)_sandbox || true
	docker run --name dev_$(PACKAGE)_sandbox ${DOCKER_OPTS} --gpus all -dt $(IMAGE_SANDBOX) bash
	docker exec -it dev_$(PACKAGE)_sandbox bash

# COMMON
tests: 
	$(shell pytest)

docker_tests:
	docker run -i  $(IMAGE_SANDBOX) python -W ignore -m $(PACKAGE).tests
