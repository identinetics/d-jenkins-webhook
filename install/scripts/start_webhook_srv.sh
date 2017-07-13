#!/usr/bin/env bash

$PYTHON3 /scripts/webhook_srv.py \
    --datadir /data \
    --getpath $GETPATH \
    --ownerlist $OWNERLIST \
    --postpath $POSTPATH
