# pki-ci-containers

## Description

Containers for building, unit and smoke testing Dogtag PKI with freeIPA.

This repo contains Dockerfile to build base image that will be used for building latest Dogtag and then running smoke test against freeIPA.

This repo is linked with [Dockerhub](https://hub.docker.com/u/dogtagpki/) with autobuild option to build the desired image.

## Naming conventions used

Images used to build and run unit tests on Dogtag PKI use the following convention: `fxx_yyy`
* `f` = represents that the image uses Fedora
* `xx` = represents Fedora version
* `yyy` = represents the PKI COPR repo version enabled (eg: 105 means 10.5)

Image use to run smoke test with freeIPA use the following convention: `fxx_ipa_yy`
* `f` = represents that the image uses Fedora
* `xx` = represents Fedora version
* `ipa` = represents that the image has freeIPA installed
* `yy` = represent the version of the freeIPA installed (eg: 4-5 means freeIPA version 4.5)

## License
(C) 2017 Red Hat, Inc. All rights reserved.

This project is open-source software.

Please comply with the LICENSE contained in each of the individual components, and the EXPORT CONTROL regulations defined at:

    http://pki.fedoraproject.org/wiki/PKI_Download
