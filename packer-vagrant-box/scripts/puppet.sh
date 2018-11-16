#!/bin/bash

# Install Puppetlabs repository
rpm -Uvh https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm

# Install Puppet agent
yum install -y puppet-agent
