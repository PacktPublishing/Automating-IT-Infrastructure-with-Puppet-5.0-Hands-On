# Installs and configures Elasticsearch.
#
# @example Basic Usage
#   include '::elasticsearch'
#
# @param [String] cluster_name Name of this Elasticsearch cluster.
# @param [String] listen_host Listen IP address for the Elasticsearch server.
class elasticsearch (
  $cluster_name = 'logserver',
  $listen_host = '127.0.0.1',
) {
  include '::java'

  include '::elasticrepo'

  package { 'elasticsearch':
    ensure  => 'present',
    require => Class['elasticrepo', 'java'],
  }

  file { 'elasticsearch.yml':
    ensure  => file,
    path    => '/etc/elasticsearch/elasticsearch.yml',
    content => epp('elasticsearch/elasticsearch.yml.epp'),
    owner   => 'root',
    group   => 'elasticsearch',
    mode    => '0640',
    require => Package['elasticsearch'],
  }

  service { 'elasticsearch':
    ensure    => running,
    enable    => true,
    subscribe => [Package['elasticsearch'], File['elasticsearch.yml']],
  }

}
