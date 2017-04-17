FROM registry.fedoraproject.org/fedora:25
LABEL \
    name="dogtagpki/pki-ci-containers:f26_104" \
    maintainer="Christian Heimes <cheimes@redhat.com>" \
    vendor="Dogtag PKI" \
    url="http://dogtagpki.org/"

# updates
RUN dnf -y update && dnf clean all

# base dependencies, 389-DS
RUN dnf install -y \
        dnf-plugins-core \
        make \
        python3-tox \
        python3-pyldap \
        rpm-build \
        sudo \
        389-ds-base \
    && dnf clean all

# build dependencies
RUN dnf builddep -y pki-core \
    && dnf clean all

# enable COPR with Dogtag 10.4 dependencies
RUN dnf copr -y enable @pki/10.4 \
    && dnf update -y \
    && dnf install -y slf4j python2-cryptography python3-cryptography \
    && dnf clean all

# build env
ENV BUILDDIR="/tmp/workdir" \
    BUILDUSER="builduser" \
    BUILDUSER_UID=1000 \
    BUILDUSER_GID=1000
VOLUME ["${BUILDDIR}"]

# https://raw.githubusercontent.com/fedora-cloud/Fedora-Dockerfiles/master/systemd/systemd/Dockerfile
ENV container docker
RUN dnf -y install systemd && dnf clean all && \
    (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*; \
    rm -f /etc/systemd/system/*.wants/*; \
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*; \
    rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME [ "/sys/fs/cgroup", "/tmp", "/run" ]
CMD ["/sbin/init"]
STOPSIGNAL SIGRTMIN+3
