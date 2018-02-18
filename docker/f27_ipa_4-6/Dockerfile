FROM registry.fedoraproject.org/fedora:27
MAINTAINER [Dinesh Prasanth M K dmoluguw@redhat.com]
ENV container=docker LANG=en_US.utf8 LANGUAGE=en_US.utf8 LC_ALL=en_US.utf8

RUN echo 'deltarpm = false' >> /etc/dnf/dnf.conf \
    && dnf update -y dnf \
    && dnf install -y dnf-plugins-core sudo wget \
    && dnf config-manager --set-enabled updates-testing \
    && dnf install -y python-srpm-macros \
    && dnf install -y @buildsys-build @development-tools \
    && dnf clean all

# Enable COPR for pki 10.6
RUN dnf copr enable -y @pki/10.6 \
    && dnf builddep -y pki-base

# Enable COPR for IPA-4-6
RUN dnf copr enable -y @freeipa/freeipa-4-6 \
    && dnf config-manager --set-disabled updates-testing \
    && dnf install -y freeipa-server freeipa-server-dns freeipa-server-trust-ad python3-ipatests --best --allowerasing \
    && dnf clean all \
    && for i in /usr/lib/systemd/system/*-domainname.service; \
    do sed -i 's#^ExecStart=/#ExecStart=-/#' $i ; done

# update everything and try to resolve conflicts
RUN dnf update -y --best --allowerasing

STOPSIGNAL RTMIN+3
VOLUME ["/freeipa", "/run", "/tmp"]
ENTRYPOINT [ "/usr/sbin/init" ]