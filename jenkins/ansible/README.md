# pki-jenkins-bot

## Description
There are 2 playbooks available for setting up different tasks after installing Jenkins.
1. [PKI-Verification-Bot](#setting-up-the-bot) Configure a Jenkins job to link with gerrithub and travis. That is, `Gerrithub <-> Jenkins <-> Travis CI`
2. [XX.X-Nightlies](#setting-up-the-nightlies) Configure a Jenkins job to create a nightly build scheduled at 2AM everyday (default: 10.6 PKI)

## Requirements
The setup requires the following installed:
    - curl
    - java 8
    - ansible 

To install `ansible` run:

    # dnf update -y
    # dnf install -y ansible


To download the java setup playbook run the following ansible-galaxy command (**Must be present**):

    ansible-galaxy install geerlingguy.java

## Setting up the bot

    ansible-playbook setup_bot.yml --extra-vars "jenkins_admin_password=<jenkins-password>" -K -k
    
    # -K will prompt for the system's root password
    # -k will prompt for SSH connection password


### Things to configure manually (ensures security)

1. Generate SSH keypair and place it in `/var/lib/jenkins/.ssh/`. REMEMBER TO SET APPROPRIATE PERMISSIONS.
2. Upload the public key to the `pki-jenkins-bot` **gerrithub** account and **github** account
3. Update the gerrit server in Jenkins to point to the public key from step #1
4. Add a new credential (SSH Username with private key) from the job and ensure that this points to the public key created in step #1


## Setting up the Nightlies (Default setup for 10.6)

    ansible-playbook setup_nightly.yml --extra-vars "jenkins_admin_password=<jenkins-password>" -K -k --ask-vault-pass
    
    # -K will prompt for the system's root password
    # -k will prompt for SSH connection password
    # --ask-vault-pass will prompt for Vault password



**Note 1:** the `extra-vars` can be take values in the `key=value` format or as `JSON` format.

**Note 2:** Ensure you run this script as a user (Don't install as `root`)

**Note 3:** Replace 2nd line of`setup_bot.yml` from `pki-jenkins-fxx` to `localhost` if you are not using the inventory file

## Defaults taken
The significant default values taken are:
- *jenkins_home*: /var/lib/jenkins
- *jenkins_hostname*: localhost
- *jenkins_http_port*: 8080
- *jenkins_admin_username*: admin
- *jenkins_admin_password*: admin
- *gerrit_project_name*: dogtagpki/pki
- *jenkins_plugins*: ["github","ws-cleanup","credentials","gerrit-trigger", "credentials-binding", "plain-credentials"]

**Note:** It is recommended to change the default `admin` password by passing the `jenkins_admin_password` as environment variable (as shown in the script above).

You can look at all the available defaults value inside [defaults](group_vars/all/defaults.yml) and [plugins](roles/installJenkins/vars/main.yml)


## License
(C) 2017 Red Hat, Inc. All rights reserved.

This project is open-source software.

Please comply with the LICENSE contained in each of the individual components, and the EXPORT CONTROL regulations defined at:

    http://pki.fedoraproject.org/wiki/PKI_Download
