FROM docker.io/almalinux/9-minimal:9.3-20240405

LABEL maintainer="Radio Bern RaBe"

# Add RaBe CA trust anchor
COPY rabe/rabe-ca.crt /etc/pki/ca-trust/source/anchors/

RUN    update-ca-trust extract \
       # ensure we have everything available from repos \
    && microdnf update -y \
    && microdnf clean all
