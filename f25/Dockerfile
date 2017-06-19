FROM registry.fedoraproject.org/fedora:25
MAINTAINER [Dinesh Prasanth dmoluguw@redhat.com]
ENV container=docker LANG=en_US.utf8 LANGUAGE=en_US.utf8 LC_ALL=en_US.utf8

RUN echo 'deltarpm = false' >> /etc/dnf/dnf.conf \ 
    && dnf update -y dnf \ 
    && dnf install -y dnf-plugins-core sudo dnf-plugins-extras wget \ 
    && dnf config-manager --set-enabled updates-testing \ 
    && dnf install -y python-srpm-macros \ 
    && dnf install -y @buildsys-build @development-tools \
    && dnf clean all

# update everything and try to resolve conflicts 
RUN dnf update -y --best --allowerasing && dnf clean all \
    && dnf config-manager --set-disabled updates-testing 

STOPSIGNAL RTMIN+3 
VOLUME ["/freeipa", "/run", "/tmp"]
ENTRYPOINT [ "/usr/sbin/init" ] 
