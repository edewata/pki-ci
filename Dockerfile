FROM fedora:latest
MAINTAINER [Dinesh Prasanth dmolugu@ncsu.edu]
ENV container=docker LANG=en_US.utf8 LANGUAGE=en_US.utf8 LC_ALL=en_US.utf8

RUN echo 'deltarpm = false' >> /etc/dnf/dnf.conf \ 
    && dnf update -y dnf \ 
    && dnf install -y dnf-plugins-core sudo dnf-plugins-extras wget \ 
    && dnf config-manager --set-enabled updates-testing \ 
    && dnf copr enable -y @freeipa/freeipa-4-5 \
    && dnf install -y python-srpm-macros \ 
    && dnf clean all

RUN dnf install -y @buildsys-build @development-tools \ 
    #&& wget https://raw.githubusercontent.com/freeipa/freeipa/ipa-4-5/freeipa.spec.in \ 
    #&& dnf builddep -y --spec ./freeipa.spec.in \ 
    #    -D "with_wheels 1" --best --allowerasing \ 
    && dnf clean all  
    #&& rm -f ./freeipa.spec.in

# update everything and try to resolve conflicts 
RUN dnf update -y --best --allowerasing && dnf clean all \
    && dnf config-manager --set-disabled updates-testing 

STOPSIGNAL RTMIN+3 
VOLUME ["/freeipa", "/run", "/tmp"]
ENTRYPOINT [ "/usr/sbin/init" ]
