all:
	@echo nothing special

DOCKER_TAG_LINUX := ghcr.io/cubao/build-env-manylinux2014-x64
docker_build_linux:
	docker build -t $(DOCKER_TAG_LINUX) -f Dockerfile.linux .
	docker images dockcross/manylinux2014-x64 --format "{{.Repository}}:{{.Tag}} -> {{.Size}}"
	docker images $(DOCKER_TAG_LINUX) --format "{{.Repository}}:{{.Tag}} -> {{.Size}}"
docker_push_linux:
	docker push $(DOCKER_TAG_LINUX)
docker_pull_linux:
	docker pull $(DOCKER_TAG_LINUX)
docker_test_linux:
	docker run --rm -v `pwd`:`pwd` -w `pwd` -it $(DOCKER_TAG_LINUX) bash

# https://stackoverflow.com/a/25817631
echo-%  : ; @echo -n $($*)
Echo-%  : ; @echo $($*)
ECHO-%  : ; @echo $* = $($*)
echo-Tab: ; @echo -n '	'
