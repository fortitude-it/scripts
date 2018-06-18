#!/bin/bash

# timestamp of YYYY-MM-DD_HH-MM-SS_TZ
# this one is specifically in zulu/UTC

date -u -Is | sed "s/T/_/gi" | sed "s/+0000/_UTC/gi" | sed "s/:/-/g"
