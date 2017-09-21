#!/bin/bash

echo "Starting PROFTPD"
# start using nodaemon mode to keep in the foreground
exec /usr/sbin/proftpd -n
