from prometheus_client import Gauge, start_http_server
import os
from dateutil import parser
from datetime import datetime
import pytz
import time

def get_expiry(host):
    str_exp = os.popen("echo | openssl s_client -showcerts -servername \"%s\" -connect \"%s:443\" 2>/dev/null | openssl x509 -inform pem -noout -dates | grep notAfter | cut -d '=' -f 2" % (host, host)).read().strip()
    exp = parser.parse(str_exp).astimezone(pytz.utc)
    return exp

def to_timestamp(dt):
    epoch = parser.parse("1970-01-01 00:00:00 UTC")
    return (dt - epoch).total_seconds()

if __name__ == '__main__':
    CERT_EXPIRY = Gauge('cert_expiry_datetime', 'SSL certificate expiry date and time (unix seconds)', ['host'])
    HOSTS = ['***REMOVED***', '***REMOVED***', '***REMOVED***', '***REMOVED***']
    port = 8000

    # Initialize gauge labels
    for host in HOSTS:
        CERT_EXPIRY.labels(host)

    start_http_server(port)
    print("Started Prometheus server on %s" % port)

    while True:
        print("Updating expiry dates for %s..." % HOSTS)
        for host in HOSTS:
            CERT_EXPIRY.labels(host).set(to_timestamp(get_expiry(host)))
        time.sleep(60)
