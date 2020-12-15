## $5 Tech Unlocked 2021!
[Buy and download this product for only $5 on PacktPub.com](https://www.packtpub.com/)
-----
*The $5 campaign         runs from __December 15th 2020__ to __January 13th 2021.__*

# Automating IT Infrastructure with Puppet 5.0 - Hands-On! [Video]
This is the code repository for [Automating IT Infrastructure with Puppet 5.0 - Hands-On! [Video]](https://www.packtpub.com/virtualization-and-cloud/automating-it-infrastructure-puppet-50-hands-video?utm_source=github&utm_medium=repository&utm_campaign=9781789130348), published by [Packt](https://www.packtpub.com/?utm_source=github). It contains all the supporting project files necessary to work through the video course from start to finish.

This repository contains sample code for the video course
"Automating IT Infrastructure with Puppet 5.0 - Hands On!",
created by Alan Hohn and published by Packt Publishing.

See the file `LICENSE.md` for license information. Also see
the modules in `code/environments/production/modules` for
items which are separately licensed by the copyright owners.

## About the Video Course
Managing your application’s infrastructure requires constant updates, security for infrastructure reliability. Automation provides faster deployments, fewer failures, improves security and reduces costs of your organisation. Puppet is an ideal tool for automating IT infrastructure in your organisation and this course will show you how.

This course will give you a hands-on tutorial with the Puppet 5 Platform to manage your IT infrastructure. You will build a custom software installation and configuration to match your application infrastructure. Explore latest features of Puppet 5 by executing, testing & deploying Puppet across your systems. Also, develop plugins for Puppet while learning to avoid common errors to overcome everyday challenges. By the end of this course, you’ll be ready to use Puppet in your own systems and ensure all of your servers are in compliance with the desired configuration.


<H2>What You Will Learn</H2>
<DIV class=book-info-will-learn-text>
<UL>
<LI>Build an automated application infrastructure by defining Puppet resources, modules, and classes&nbsp; 
<LI>Deploy Puppet agents and servers in a public cloud environment so that you can quickly see the results of your Puppet code&nbsp; 
<LI>Create Puppet classes and modules to apply your automation and multiple servers in parallel&nbsp; 
<LI>Capture unique configuration for each system using Facter and Hiera so your Puppet code can be more modular and reusable&nbsp; 
<LI>Automatically configure any software using Puppet resources and embedded Puppet templates </LI></UL></DIV>

## Instructions and Navigation
### Assumed Knowledge
To fully benefit from the coverage included in this course, you will need:<br/>
To fully benefit from the coverage included in this course, you will need:

●	Basic Linux command-line skills

●	Some knowledge of system administration (installing packages, copying files)

No prior knowledge of Puppet is needed.

### Technical Requirements
This course has the following software requirements:<br/>
Minimum Hardware Requirements

To install and run Puppet, students should have access to a computer system with at least the following:

•	OS: Linux (CentOS 7)

•	Processor: Dual-core Intel or AMD

•	Memory: 2 GB RAM

•	Storage: 20 GB

Students can use a Windows or Mac OS computer to view examples and develop Puppet code, but will need an SSH client to connect to the Puppet server and transfer the code.

Software Requirements

•	Atom IDE , Latest Version

o	Recommended Packages: atom-ide-ui, ide-puppet

Other Requirements

This course demonstrates the use of Puppet for IT automation across multiple computer systems. To follow along with all of these examples, the student will need access to physical servers, virtual servers, or a cloud environment such as Amazon Web Services. The exercise files include configuration to run virtual machines using Vagrant and VirtualBox.

## Puppet Code

Puppet code is contained in the `code` subdirectory. This
code installs the Elasticsearch, Logstash, and Kibana (ELK)
stack onto a group of CentOS 7 / RHEL 7 machines. At present,
the manifests are configured to install the ELK stack on a
single machine and to configure Filebeat on client machines
to ship logs to the log server.

To use this with existing servers, the directory
`code/environments/production` can be placed in the correct
location on a Puppet server and used directly. See the main
manifest `manifests/site.pp` to review or modify the
configured names of servers.

## Vagrant Setup

To demonstrate the Puppet code, a Vagrant configuration is
included in the repository. This includes a `Vagrantfile`,
a `config` directory that sets up the Puppet server and agents
on a set of Vagrant boxes to make it possible to modify Puppet
code on the host system and immediately apply it in the VMs,
and a `vagrant` environment under `code/environments` that
sets up the Vagrant hosts so they can find the Puppet server.

The `Vagrantfile` is configured for VirtualBox and should be run
on a server with sufficient memory for all machines. Alternatively,
it can be modified to use another Vagrant provider such as AWS.
The Vagrant box must already have Puppet 5 agent installed and have the
Puppet Yum repository configured (the Puppet server will be installed
as part of the automated setup).

To use, set up Vagrant and VirtualBox per the documentation and
run `vagrant up`. Then, once the machines are up and running,
use `vagrant ssh puppet` to get a shell prompt inside the Puppet
server, and sign the client certificates using:

```
sudo /opt/puppetlabs/puppet/bin/puppet cert sign --all
```

The agents will then apply their catalogs from the Puppet server. This
may take more than 30 minutes as that is the default frequency for Puppet
agents to check with the server for configuration changes.

The log server includes NGINX listening on port 80 as a reverse proxy for
Kibana. This port is forwarded to the host as port 8080, so once the log
server has completed applying its catalog, you can visit
http://localhost:8080 in the browser to see and set up Kibana.

## Vagrant Box
To provide a Vagrant box for VirtualBox with Puppet 5 agent installed,
the `packer-vagrant-box` directory includes a Packer build JSON that
creates a Vagrant box running CentOS 7. This automates the creation of
the Vagrant box that is used with this repository.


## Related Products
* [Hands-On DevOps with Ansible [Video]](https://www.packtpub.com/virtualization-and-cloud/hands-devops-ansible-video?utm_source=github&utm_medium=repository&utm_campaign=9781789344622)

* [Hands-On Infrastructure Automation with Ansible [Video]](https://www.packtpub.com/application-development/hands-infrastructure-automation-ansible-video?utm_source=github&utm_medium=repository&utm_campaign=9781788991599)

* [Puppet 5.0 Essentials for Configuration Management [Video]](https://www.packtpub.com/virtualization-and-cloud/puppet-50-essentials-configuration-management-video?utm_source=github&utm_medium=repository&utm_campaign=9781789137255)

