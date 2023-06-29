all:
	@echo nothing special

DOCKER_TAG_LINUX := ghcr.io/cubao/build-env-manylinux2014-x64:v0.0.4
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

DOCKER_TAG_WINDOWS := ghcr.io/cubao/build-env-windows-x64:v0.0.1
docker_build_windows:
	docker build -t $(DOCKER_TAG_WINDOWS) -f Dockerfile.windows .
	docker images dockcross/windows-static-x64 --format "{{.Repository}}:{{.Tag}} -> {{.Size}}"
	docker images $(DOCKER_TAG_WINDOWS) --format "{{.Repository}}:{{.Tag}} -> {{.Size}}"
docker_push_windows:
	docker push $(DOCKER_TAG_WINDOWS)
docker_pull_windows:
	docker pull $(DOCKER_TAG_WINDOWS)
docker_test_windows:
	docker run --rm -v `pwd`:`pwd` -w `pwd` -it $(DOCKER_TAG_WINDOWS) bash

DOCKER_TAG_MACOS := ghcr.io/cubao/build-env-macos-arm64:v0.0.1
docker_build_macos:
	docker build -t $(DOCKER_TAG_MACOS) -f Dockerfile.macos .
	docker images ghcr.io/goreleaser/goreleaser-cross:v1.19.2 --format "{{.Repository}}:{{.Tag}} -> {{.Size}}"
	docker images $(DOCKER_TAG_MACOS) --format "{{.Repository}}:{{.Tag}} -> {{.Size}}"
docker_push_macos:
	docker push $(DOCKER_TAG_MACOS)
docker_pull_macos:
	docker pull $(DOCKER_TAG_MACOS)
docker_test_macos:
	docker run --rm -v `pwd`:`pwd` -w `pwd` -it $(DOCKER_TAG_MACOS) bash

DOCKER_TAG_EMSDK := ghcr.io/cubao/build-env-emsdk:v0.0.1
docker_build_emsdk:
	docker build -t $(DOCKER_TAG_EMSDK) -f Dockerfile.emsdk .
	docker images $(DOCKER_TAG_EMSDK) --format "{{.Repository}}:{{.Tag}} -> {{.Size}}"
docker_push_emsdk:
	docker push $(DOCKER_TAG_EMSDK)
docker_pull_emsdk:
	docker pull $(DOCKER_TAG_EMSDK)
docker_test_emsdk:
	docker run --rm -v `pwd`:`pwd` -w `pwd` -it $(DOCKER_TAG_EMSDK) bash

# https://stackoverflow.com/a/25817631
echo-%  : ; @echo -n $($*)
Echo-%  : ; @echo $($*)
ECHO-%  : ; @echo $* = $($*)
echo-Tab: ; @echo -n '	'
