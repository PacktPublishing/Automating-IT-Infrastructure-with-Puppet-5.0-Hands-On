# Installs and configures NGINX.
#
# @example Basic Usage
#   include '::nginx'
#
# @param [Boolean] default_server Whether to include the default server block.
class nginx (
  $default_server = true,
  $confd_templates = undef,
){

  ensure_packages(['epel-release'], {'ensure' => 'present'})

  package { 'nginx':
    ensure  => 'present',
    require => Package['epel-release'],
  }

  file { 'nginx.conf':
    ensure  => file,
    path    => '/etc/nginx/nginx.conf',
    content => epp('nginx/nginx.conf.epp'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['nginx'],
  }

  $confd_templates.each |String $tmpl| {
    $targetfile = basename($tmpl)
    file { "/etc/nginx/conf.d/${targetfile}":
      ensure  => file,
      content => epp("${tmpl}.epp"),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package['nginx'],
      notify  => Service['nginx'],
    }
  }

  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => [Package['nginx'], File['nginx.conf']],
  }
}
