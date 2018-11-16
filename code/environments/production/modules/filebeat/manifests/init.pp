# Installs and configures Filebeat.
#
# @example Basic Usage
#   include '::filebeat'
#
# @param [String] logstash_loc Host:Port for the Logstash server.
class filebeat (
  $logstash_loc = 'logserver:5044',
){
  include '::elasticrepo'

  package { 'filebeat':
    ensure  => 'present',
    require => Class['elasticrepo'],
  }

  file { 'filebeat.yml':
    ensure  => file,
    path    => '/etc/filebeat/filebeat.yml',
    content => epp('filebeat/filebeat.yml.epp'),
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    require => Package['filebeat'],
  }

  service { 'filebeat':
    ensure    => running,
    enable    => true,
    subscribe => [Package['filebeat'], File['filebeat.yml']],
  }

}
