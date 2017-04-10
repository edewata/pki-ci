FROM registry.fedoraproject.org/fedora:25
MAINTAINER Christian Heimes <cheimes@redhat.com>
LABEL \
    name="dogtagpki/pki-ci-containers:f25" \
    vendor="Dogtag PKI" \
    url="http://dogtagpki.org/"

# updates
RUN dnf -y update && dnf clean all

# base dependencies
RUN dnf install -y \
        dnf-plugins-core \
        make \
        python3-tox \
        python3-pyldap \
        rpm-build \
        sudo \
    && dnf clean all

# build dependencies
RUN dnf builddep -y pki-core \
    && dnf clean all

# build env
ENV BUILDDIR="/tmp/workdir"
VOLUME ["${BUILDDIR}"]
WORKDIR ${BUILDDIR}
