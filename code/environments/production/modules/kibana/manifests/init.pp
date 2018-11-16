# Installs and configures Kibana.
#
# @example Basic Usage
#   include '::kibana'
#
# @param [String] elasticsearch_url Address for the Elasticsearch server.
# @param [String] listen_host Listen IP address for the Kibana server.
class kibana (
  $elasticsearch_url = 'http://localhost:9200',
  $listen_host = '127.0.0.1',
  $server_name = 'logserver',
){
  include '::elasticrepo'

  package { 'kibana':
    ensure  => 'present',
    require => Class['elasticrepo'],
  }

  file { 'kibana.yml':
    ensure  => file,
    path    => '/etc/kibana/kibana.yml',
    content => epp('kibana/kibana.yml.epp'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['kibana'],
  }

  service { 'kibana':
    ensure    => running,
    enable    => true,
    subscribe => [Package['kibana'], File['kibana.yml']],
  }

}
