#!/bin/bash

set -eu

function usageExit () {
    echo "Usage: build <uat|prod> <version>"
    exit 1
}

if [[ "$#" -ne 2 ]]; then
    usageExit
fi

ENV="$1"
VERSION="$2"

RED='\e[37m\e[41m'
RESET='\e[m'

case "$ENV" in
    uat)
        PROJECT=***REMOVED***
        ;;
    prod)
        PROJECT=***REMOVED***
        ;;
    *)
        usageExit
esac

printf "Build and push cert-expiry-monitor ${RED}${VERSION}${RESET} to ${RED}${PROJECT}${RESET} now? (y/n) "
read -n 1 -rs
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then

    echo "Building docker image..."
    docker build . -t "***REMOVED***/$PROJECT/cert-expiry-monitor:$VERSION"
    echo "Pushing docker image..."
    docker push "***REMOVED***/$PROJECT/cert-expiry-monitor:$VERSION"
    echo "Success!"
fi
