node 'logserver' {
  include '::elasticsearch'

  include '::kibana'

  class { 'nginx':
    default_server  => false,
    confd_templates => ['kibana/kibana.conf'],
  }

  include '::logstash_syslog'
}

node 'puppet' {
  include '::puppetdb'
  include '::puppetdb::serverconfig'
  include '::filebeat'
  Sshkey <<| |>>
}

node /^client\d+$/ {
  include '::filebeat'
  @@sshkey { $facts['hostname']:
    ensure => present,
    type   => $facts["ssh"]["ecdsa"]["type"],
    key    => $facts["ssh"]["ecdsa"]["key"],
  }

}
