# pki-jenkins-bot

## Description
This will install Jenkins on `localhost` and configure Jenkins to link with gerrithub and travis. That is, `Gerrithub <-> Jenkins <-> Travis CI`

## Requirements
The setup requires the following installed:
    - curl
    - java 8
    - ansible 

To install `ansible` run:

    # dnf update -y
    # dnf install -y ansible

## Setting up the bot
To download the java setup playbook run the following ansible-galaxy command:

    ansible-galaxy install geerlingguy.java

The following command installs java (if not installed), configures the bot:

    ansible-playbook install_jenkins.yml --extra-vars '{"jenkins_admin_password":"<jenkins-password>", "github_token":"<github-token>"}' -K
    # -K will prompt for the system's root password

**Note:** the `extra-vars` can be take values in the `key=value` format or as `JSON` format (as shown above).

## Defaults taken
The significant default values taken are:
- *jenkins_home*: /var/lib/jenkins
- *jenkins_hostname*: localhost
- *jenkins_http_port*: 8080
- *jenkins_admin_username*: admin
- *jenkins_admin_password*: admin
- *gerrit_project_name*: dogtagpki/pki
- *jenkins_plugins*: ["github","ws-cleanup","credentials","gerrit-trigger", "credentials-binding", "plain-credentials", "postbuild-task", "envinject"]

**Note:** It is recommended to change the default `admin` password by passing the `jenkins_admin_password` as environment variable (as shown in the script above).

You can look at all the available defaults value inside [defaults](roles/installJenkins/defaults/main.yml) and [plugins](roles/installJenkins/vars/main.yml)

## License
(C) 2017 Red Hat, Inc. All rights reserved.

This project is open-source software.

Please comply with the LICENSE contained in each of the individual components, and the EXPORT CONTROL regulations defined at:

    http://pki.fedoraproject.org/wiki/PKI_Download