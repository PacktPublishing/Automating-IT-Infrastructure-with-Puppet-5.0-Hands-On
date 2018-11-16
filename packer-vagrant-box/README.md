# Packer Vagrant Box for Puppet 5

This directory includes Packer configuration to create
a Vagrant box, running on VirtualBox, that has Puppet 5
agent installed and the Puppet Yum repository enabled.

To use, set up Packer and VirtualBox per the documentation
and run `packer build packer.json`.

After building the virtual machine, this will create a
file `packer_puppet5_virtualbox.box` file in the current
directory. Add this file to Vagrant as a box:

```shell
vagrant box add --name=puppet5 packer_puppet5_virtualbox.box
```
