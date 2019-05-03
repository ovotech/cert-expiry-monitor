#!/bin/bash

set -eu

function usageExit () {
    echo "Usage: ./push.sh"
    exit 1
}

if [[ "$#" -ne 0 ]]; then
    usageExit
fi

echo "Pushing docker image..."
docker login -u "${DOCKER_HUB_USERNAME}" -p "${DOCKER_HUB_PASSWORD}"
docker push "ovotech/cert-expiry-monitor"

echo "Success!"
