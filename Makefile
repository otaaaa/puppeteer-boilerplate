REPOSITORY := ghcr.io/otaaaa
WORK_DIR := $(shell git rev-parse --show-toplevel)
GIT_SHA := $(shell git rev-parse --short HEAD)

.PHONY: build
build:
	echo ${GIT_SHA}
	docker build --tag ${REPOSITORY}/puppeteer-stealth:${GIT_SHA} .
	docker tag ${REPOSITORY}/puppeteer-stealth:${GIT_SHA} ${REPOSITORY}/puppeteer-stealth:latest

.PHONY: run
run:
	docker run -i --init --cap-add=SYS_ADMIN --rm \
	  -e PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome-stable \
	  -v ${WORK_DIR}:/home/pptruser \
	  -w /home/pptruser \
	  --platform linux/amd64 \
	  ${REPOSITORY}/puppeteer-stealth:latest /bin/bash -c "npm start"
