#!/bin/bash
DATA_DIR=data
DOCKER_VER=17.03
NODE_VER=6.10

rm -fr ./$DATA_DIR
mkdir ./$DATA_DIR
cd ./$DATA_DIR

git clone https://github.com/docker-library/docker

cp -a docker/$DOCKER_VER/. ./
cp -a ./dind/. ./
rm Dockerfile

sed "s/apk add --no-cache/yum -y install/g;s/FROM.*/FROM cubedhost\/centos7-node/g" docker/$DOCKER_VER/Dockerfile > Dockerfile
echo "RUN yum -y install wget which" >> Dockerfile
sed "s/apk add --no-cache/yum -y install/g;s/adduser -S -G/useradd -g/g;s/addgroup -S/groupadd/g;/FROM.*/d" docker/$DOCKER_VER/dind/Dockerfile >> Dockerfile 

rm -rf docker

cp Dockerfile ../

cd -
rm -fr ./$DATA_DIR
