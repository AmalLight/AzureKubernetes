#!/bin/bash

set -euo pipefail ;

stat './project-root.dir' > '/dev/null'

set -x ;

exec docker run \
  --rm \
  --name av-provisioner \
  -v "${PWD}/logs":'/srv/logs' \
  -v "${PWD}/config":'/srv/ansible/config' \
  -v "${PWD}/../hosts":'/srv/hosts' \
  -v "${PWD}/../vault":'/srv/vault' \
  -it \
  --env ANSIBLE_HOST_KEY_CHECKING=False \
  av-provisioner:latest \
  bash
