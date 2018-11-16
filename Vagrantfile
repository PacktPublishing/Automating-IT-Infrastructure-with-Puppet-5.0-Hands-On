# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

servers = {
  "puppet": {
    "cpus": "2",
    "memory": "2048",
  },
  "logserver": {
    "cpus": "2",
    "memory": "4096",
  },
  "client01": {
    "cpus": "1",
    "memory": "1024",
  },
  "client02": {
    "cpus": "1",
    "memory": "1024",
  },
}

hosts = {
  "puppet": {
    "ip": "10.10.1.11",
  },
  "logserver": {
    "ip": "10.10.1.21",
  },
  "client01": {
    "ip": "10.10.1.31",
  },
  "client02": {
    "ip": "10.10.1.32",
  },
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "puppet5"


  config.vm.provision "puppet" do |puppet|
    puppet.environment_path = "code/environments"
    puppet.environment = "vagrant"
    puppet.module_path = "code/environments/production/modules"
    puppet.facter = {
      "hosts": hosts.to_json,
    }
    puppet.options = "--verbose"
  end

  servers.each do |name, data|
    config.vm.define name do |svr|
      svr.vm.hostname = name
      svr.vm.provider "virtualbox" do |vb|
        vb.memory = data[:memory]
        vb.cpus = data[:cpus]
      end
      svr.vm.provision "shell", path: "config/setup.sh", args: "#{name}"
      svr.vm.network "private_network", ip: hosts[name][:ip]
      svr.vm.network "forwarded_port", guest: 80, host: 8080 if name == :logserver
    end
  end

end
