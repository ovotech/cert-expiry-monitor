# Certificate expiry monitor

Quick hack to get a time-to-expiry metric into our Grafana dashboards, prompted by news that the O2 outage on 6 Dec 2018 [was caused by an expired certificate](https://www.ericsson.com/en/press-releases/2018/12/update-on-software-issue-impacting-certain-customers).

## Components

1. `monitor.py`: Python script that uses `openssl` and some `bash` stuff to expose certificate expiry datetimes as Prometheus metrics
1. `requirements.txt`: Python module requirements. If running locally, create a new virtualenv, activate it, and use `pip install -r requirements.txt` to install these
1. `Dockerfile`: Spec for the Docker image. To build/push this, do something like: `docker build . -t ***REMOVED***/cert-expiry-monitor:0.1; docker push ***REMOVED***/cert-expiry-monitor:0.1`
1. `deployment.yaml`: k8s deployment file. To deploy, do something like `kubectl apply -f deployment.yaml`

## Status

Currently, this is only deployed in UAT, and the gauges have been added to [the UAT dashboard](https://***REMOVED***/).
