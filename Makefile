.PHONY: all build deploy debug peerconf clean

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
DIST_DIR = ./dist

all: build

build:
	-mkdir $(DIST_DIR)
	docker build --pull --rm --squash -f Dockerfile -t wireguard .
	docker save -o $(DIST_DIR)/wireguard.tar wireguard

deploy: build
	rsync -ahP $(DIST_DIR)/wireguard.tar hosting:~/docker/images

debug: build
	docker run --cap-add net_admin --rm -it -p 127.0.0.1:2000:51820/udp wireguard:latest

peerconf:
	qrencode -t ANSI256UTF8 < ./conf/peer.conf

clean:
	-docker system prune -f
	-rm -rf $(DIST_DIR)/*
