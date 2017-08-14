#!/usr/bin/env bash

# run trigger_jenkins.py POLLING_INTERVAL seconds

while true; do
    $PYTHON3 /scripts/trigger_jenkins.py \
        --config /data/.config \
        --datadir /data \
        --jenkins-baseurl $JENKINSBASEURL \
        --jenkins-apitoken $JENKINSAPITOKEN \
        --user $JENKINSUSER \
        --password $JENKINSUSERTOKEN \
        --webhook-proxy $WEBHOOKPROXY $TRIGGER_JENKINS_OPTS

    sleep $POLLING_INTERVAL
done