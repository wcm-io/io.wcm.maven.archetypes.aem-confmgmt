About Maven Archetype for AEM Configuration Management
======================================================

Maven Archetype for creating infrastructure deployment and configuration management projects for AEM.

[![Maven Central](https://maven-badges.herokuapp.com/maven-central/io.wcm.maven.archetypes/io.wcm.maven.archetypes.aem-confmgmt/badge.svg)](https://maven-badges.herokuapp.com/maven-central/io.wcm.maven.archetypes/io.wcm.maven.archetypes.aem-confmgmt)


### Documentation

* [Usage][usage]
* [Changelog][changelog]


### Overview

With this archetype you can create a "Configuration Management" project for your CONGA-enabled AEM project and use it to setup the AEM infrastructure and deploy the AEM application with all required configuration and Adobe artifacts. Ideally the AEM project itself was set up with the [wcm.io Maven Archetype for AEM][aem-archetype].

Features:

* Supports AEM 6.3 and higher
* Supports all [CONGA][conga]-enabled AEM projects that publish a `config-definition` artifact describing the AEM application and configuration parameters
* Uses the [Ansible Automation for AEM][aem-ansible]
* Optional: Define and generate AWS machines and infrastructure using [Terraform][terraform]
* Optional: Use local [Vagrant][vagrant] VM als Ansible Control host
* Sets up multiple example stages: DEV and PROD
* All sensitive data (passwords, crypto keys, license files) in the generated project are encrypted using Ansible Vault

See [Usage][usage] for a detailed documentation.


### GitHub Repository

Sources: https://github.com/wcm-io/io.wcm.maven.archetypes.aem-confmgmt


### Further Resources

* [adaptTo() 2018 Talk: Maven Archetypes for AEM][adaptto-talk-2018-aem-archetypes]
* [wcm.io Ansible Automation for AEM][aem-ansible]


[usage]: usage.html
[changelog]: changes-report.html
[aem-archetype]: ../aem/
[conga]: https://devops.wcm.io/conga/
[aem-ansible]: https://devops.wcm.io/ansible-aem/
[terraform]: https://www.terraform.io/
[vagrant]: https://www.vagrantup.com/
[adaptto-talk-2018-aem-archetypes]: https://adapt.to/2018/en/schedule/maven-archetypes-for-aem.html
