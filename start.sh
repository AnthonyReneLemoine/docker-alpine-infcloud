#!/bin/sh

/bin/bash
/usr/sbin/nginx
/usr/bin/radicale

#pause script to keep container running...
echo "Services for container successfully started."
stop="no"
while [ "$stop" == "no" ]
do
echo "Type [stop] to shutdown container..."
read input
if [ "$input" == "stop" ]; then stop="yes"; fi
done
