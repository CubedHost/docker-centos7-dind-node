#!/bin/bash

DOCKER_VER=18.06

echo "Docker Version: ${DOCKER_VER}"

DIND_ENTRY=dockerd-entrypoint.sh
DIND_URL=https://raw.githubusercontent.com/docker-library/docker/master/${DOCKER_VER}/dind/${DIND_ENTRY}

echo "Downloading dind script..."
curl -O ${DIND_URL}

echo "Patching for overlayfs"
mv ${DIND_ENTRY}{,.temp}
sed 's/=vfs/=overlay/g' ${DIND_ENTRY}.temp > ${DIND_ENTRY}
rm ${DIND_ENTRY}.temp

echo "Done!"
