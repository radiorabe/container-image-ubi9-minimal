FROM ghcr.io/almalinux/9-minimal:9.8-20261114@sha256:497a580e80d199884cb9fce025384206385790585c5e83477bfc0b9670b6aa88

LABEL maintainer="Radio Bern RaBe"

# Add RaBe CA trust anchor
COPY rabe/rabe-ca.crt /etc/pki/ca-trust/source/anchors/

RUN <<-EOR
    set -xe
    update-ca-trust extract
    # ensure we have everything available from repos
    microdnf update -y
    microdnf clean all
EOR
