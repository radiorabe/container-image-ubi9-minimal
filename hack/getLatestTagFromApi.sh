#!/bin/bash

#
# Grab latest container image tag from Red Hat's API
#
# This scripts exists because it's easier to get the latest version from the API than to rely on rate-limited container registries for CI
#

set -xe -o pipefail

curl -sL https://registry.access.redhat.com/v2/ubi9/ubi-minimal/tags/list | jq -r '.tags | .[]' | grep -v -P '(latest|source)' | sort | tail -1
