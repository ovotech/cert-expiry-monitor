# Certificate expiry monitor

Quick hack to get a time-to-expiry metric into our Grafana dashboards, prompted by news that the O2 outage on
6 Dec 2018 [was caused by an expired certificate](https://www.ericsson.com/en/press-releases/2018/12/update-on-software-issue-impacting-certain-customers).

## Usage

### Configuration

| Environment variable | Required | Notes                                         |
| -------------------- |:--------:| --------------------------------------------- |
|   `MONITOR_HOSTS`    |   Yes    | Comma-separated lists of hostnames to monitor |

### Metrics

The container exposes a Prometheus metrics endpoint on port 8000. The metrics are all named `cert_expiry_datetime`,
and are labelled with `host=<hostname>`.

## Components

1. `monitor.py`: Python script that uses `openssl` and some `bash` stuff to expose certificate expiry datetimes as Prometheus metrics
1. `requirements.txt`: Python module requirements. If running locally, create a new virtualenv, activate it, and use `pip install -r requirements.txt` to install these
1. `Dockerfile`: Spec for the Docker image. To build/push this, do something like: `./build.sh 0.2`
1. `example-deployment.yaml`: Example k8s deployment file.

## Status

[![CircleCI](https://circleci.com/gh/ovotech/cert-expiry-monitor.svg?style=svg&circle-token=8aaad6f07da10ff5d01d79c5d3c67353d5881b74)](https://circleci.com/gh/ovotech/cert-expiry-monitor)
