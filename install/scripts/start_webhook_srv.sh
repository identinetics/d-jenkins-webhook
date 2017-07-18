#!/usr/bin/env bash

$PYTHON3 /scripts/webhook_srv.py \
    --verbose \
    --datadir /data \
    --getpath $GETPATH \
    --ownerlist $OWNERLIST \
    --postpath $POSTPATH
