#!/bin/bash

PERSONALITY="${PERSONALITY:-Linux 5.0}"

osfooler-ng -i eth0 -m "${PERSONALITY}"
