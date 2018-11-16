# Configures Logstash to receive syslog data via Filebeats.
#
# @example Basic Usage
#   include '::logstash_syslog'
class logstash_syslog {
  include '::logstash'

  file { '/etc/logstash/conf.d':
    ensure  => file,
    source  => 'puppet:///modules/logstash_syslog/conf.d',
    recurse => remote,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['logstash'],
    notify  => Service['logstash'],
  }

}
