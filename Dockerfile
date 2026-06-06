FROM ghcr.io/almalinux/9-minimal:9.7-20260509@sha256:6d1e7eaebc399d9d8dcfea8622803c65c304782809c5ddfdeaab52efd0d32b33

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
