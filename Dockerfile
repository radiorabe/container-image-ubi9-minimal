FROM ghcr.io/almalinux/9-minimal:9.9-20261116@sha256:3e24285c7341003c4448ce0a9c3295e3736bcb1a21c47220b32a87cd3716b621

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
