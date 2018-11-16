# Configures the Puppet server to talk to PuppetDB.
#
# @example Basic Usage
#   include '::puppetdb'
class puppetdb::serverconfig(
  $puppetdb_url = 'https://puppet:8081',
) {

  package { 'puppetdb-termini':
    ensure  => 'present',
  }

  ensure_resource('service', 'puppetserver', {'ensure' => 'running'})

  file { 'puppetdb.conf':
    ensure  => file,
    path    => '/etc/puppetlabs/puppet/puppetdb.conf',
    content => epp('puppetdb/puppetdb.conf.epp'),
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0644',
    require => Package['puppetdb-termini'],
    notify  => Service['puppetserver'],
  }

  ini_setting { 'puppetserver_storeconfigs':
    ensure  => present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'master',
    setting => 'storeconfigs',
    value   => true,
    notify  => Service['puppetserver'],
  }

  ini_setting { 'puppetserver_storeconfigs_backend':
    ensure  => present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'master',
    setting => 'storeconfigs_backend',
    value   => 'puppetdb',
    notify  => Service['puppetserver'],
  }

  file { '/etc/puppetlabs/puppet/routes.yaml':
    ensure  => file,
    source  => 'puppet:///modules/puppetdb/routes.yaml',
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0644',
    notify  => Service['puppetserver'],
  }

}
