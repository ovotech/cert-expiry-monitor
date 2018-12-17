#!/bin/bash

set -eu

function usageExit () {
    echo "Usage: deploy <uat|prod> <version>"
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
        MONITOR_HOSTS=***REMOVED***,***REMOVED***,***REMOVED***,***REMOVED***
        KUBE_CLUSTER=gke_***REMOVED***_europe-west2-b_cluster-1
        ;;
    prod)
        PROJECT=***REMOVED***
        MONITOR_HOSTS=***REMOVED***,***REMOVED***,***REMOVED***
        KUBE_CLUSTER=gke_***REMOVED***_europe-west2-b_cluster-1
        ;;
    *)
        usageExit
esac

printf "Deploy cert-expiry-monitor ${RED}${VERSION}${RESET} to ${RED}${PROJECT}${RESET} now? (y/n) "
read -n 1 -rs
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then

    echo "Deploying..."
    cat deployment.yaml | \
        sed "s/\${MONITOR_HOSTS}/$MONITOR_HOSTS/g" | \
        sed "s/\${PROJECT}/$PROJECT/g" | \
        sed "s/\${VERSION}/$VERSION/g" | \
        kubectl apply --context="${KUBE_CLUSTER}" -f -
    echo "Success!"
fi
