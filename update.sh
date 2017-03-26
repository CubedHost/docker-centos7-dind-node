#!/bin/bash
DOCKER_VER=17.03
NODE_VER=6.10

git clone https://github.com/docker-library/docker

cp -a docker/$DOCKER_VER/. ./
cp -a ./dind/. ./
rm Dockerfile docker-entrypoint.sh

sed "s/apk add --no-cache/yum -y install/g;
    s/FROM.*/FROM cubedhost\/centos7-node/g;
    /COPY docker-entrypoint.sh/d
    /ENTRYPOINT/d
    /CMD/d" \
    docker/$DOCKER_VER/Dockerfile > Dockerfile

echo "RUN yum -y install wget which" >> Dockerfile
sed "s/apk add --no-cache/yum -y install/g;s/adduser -S -G/useradd -g/g;s/addgroup -S/groupadd/g;/FROM.*/d" docker/$DOCKER_VER/dind/Dockerfile >> Dockerfile 

rm -rf docker
