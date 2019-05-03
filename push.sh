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
# docker push "ovotech/cert-expiry-monitor"
echo "(Not actually pushing Docker image because we haven't sorted out auth yet)"

echo "Success!"
