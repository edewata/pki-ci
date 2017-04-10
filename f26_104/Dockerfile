FROM registry.fedoraproject.org/fedora:26
MAINTAINER Christian Heimes <cheimes@redhat.com>
LABEL \
    name="dogtagpki/pki-ci-containers:f26_104" \
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

# enable COPR with Dogtag 10.4 dependencies
RUN dnf copr -y enable @pki/10.4 \
    && dnf update -y \
    && dnf clean all

# build env
ENV BUILDDIR="/tmp/workdir"
VOLUME ["${BUILDDIR}"]
WORKDIR ${BUILDDIR}
