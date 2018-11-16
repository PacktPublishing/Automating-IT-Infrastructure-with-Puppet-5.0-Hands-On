# Installs and configures PuppetDB.
#
# @example Basic Usage
#   include '::puppetdb'
#
# @param [String] database_loc Host:Port for PostgreSQL database server.
class puppetdb (
  $database_url = 'localhost:5432',
){
  include '::postgresql'

  postgresql::user { 'puppetdb':
    password => 'puppetdb',
    before   => Service['puppetdb'],
  }

  postgresql::database { 'puppetdb':
    owner  => 'puppetdb',
    before => Service['puppetdb'],
  }

  postgresql::extension { 'pg_trgm':
    database => 'puppetdb',
    before   => Service['puppetdb'],
  }

  package { 'puppetdb':
    ensure => 'present',
  }

  package { 'puppet-client-tools':
    ensure => 'present',
  }

  file { 'puppetdb_database.ini':
    ensure  => file,
    path    => '/etc/puppetlabs/puppetdb/conf.d/database.ini',
    content => epp('puppetdb/database.ini.epp'),
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0644',
    require => Package['puppetdb'],
  }

  service { 'puppetdb':
    ensure    => running,
    enable    => true,
    require   => Service['postgresql'],
    subscribe => [Package['puppetdb'], File['puppetdb_database.ini']],
  }

}
