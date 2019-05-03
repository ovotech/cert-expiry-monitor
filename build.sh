#!/bin/bash

set -eu

function usageExit () {
    echo "Usage: build <version>"
    exit 1
}

if [[ "$#" -ne 1 ]]; then
    usageExit
fi

VERSION="$1"

echo "Building docker image..."
docker build . -t "ovotech/cert-expiry-monitor:$VERSION" -t "ovotech/cert-expiry-monitor:latest"

echo "Pushing docker image..."
docker push "ovotech/cert-expiry-monitor"

echo "Success!"
