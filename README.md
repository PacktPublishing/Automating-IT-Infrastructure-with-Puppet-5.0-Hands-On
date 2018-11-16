# Automating IT Infrastructure with Puppet 5.0

This repository contains sample code for the video course
"Automating IT Infrastructure with Puppet 5.0 - Hands On!",
created by Alan Hohn and published by Packt Publishing.

See the file `LICENSE.md` for license information. Also see
the modules in `code/environments/production/modules` for
items which are separately licensed by the copyright owners.

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
