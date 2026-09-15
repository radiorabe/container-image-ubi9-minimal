FROM ghcr.io/almalinux/9-minimal:9.8-20260902@sha256:113f4008c804f871eeb813cb2872c708b32c790987f6d5682e5eb2399cc4c6d2

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
