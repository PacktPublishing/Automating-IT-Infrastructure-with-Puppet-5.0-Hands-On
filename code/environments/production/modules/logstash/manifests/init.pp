# Installs and configures Logstash.
#
# @example Basic Usage
#   include '::logstash'
#
# @param [String] elasticsearch_loc Host:Port for the Elasticsearch server.
class logstash (
  $elasticsearch_loc = 'localhost:9200',
){
  include '::java'

  include '::elasticrepo'

  package { 'logstash':
    ensure  => 'present',
    require => Class['elasticrepo', 'java'],
  }

  exec { 'logstash-system-install':
    command => '/usr/share/logstash/bin/system-install',
    creates => '/etc/systemd/system/logstash.service',
    user    => 'root',
    group   => 'root',
  }

  file { '/etc/logstash/conf.d/30-elasticsearch-output.conf':
    ensure  => file,
    content => epp('logstash/elasticsearch_output.conf.epp'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['logstash'],
    notify  => Service['logstash'],
  }

  service { 'logstash':
    ensure    => running,
    enable    => true,
    require   => Exec['logstash-system-install'],
    subscribe => Package['logstash'],
  }

}
