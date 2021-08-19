#!/usr/bin/env bash

set -euo pipefail;

FULL_IMAGE='av-provisioner'
IMAGE_TAG='latest'

stat './project-root.dir' > '/dev/null'

set -x ;

exec docker build \
  './src/' \
  -f './src/docker/provisioner.dockerfile' \
  -t "${FULL_IMAGE}:${IMAGE_TAG}"
