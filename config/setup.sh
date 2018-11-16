#!/bin/bash
NODE=$1
cp /vagrant/config/puppet.conf /etc/puppetlabs/puppet/puppet.conf

if [ "${NODE}" == "puppet" ]
then
  yum install -y puppetserver
  cp /vagrant/config/puppetserver /etc/sysconfig/puppetserver
  cp /vagrant/config/puppetserver.conf /etc/puppetlabs/puppetserver/conf.d/puppetserver.conf
  systemctl enable puppetserver
  systemctl restart puppetserver
fi

systemctl enable puppet
systemctl start puppet
