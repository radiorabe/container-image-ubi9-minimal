FROM ghcr.io/almalinux/9-minimal:9.8-20260602@sha256:5eeac2d7a256709412f9a36cb4a8878ae322b2674f4c5c9d576d801f37798685

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
