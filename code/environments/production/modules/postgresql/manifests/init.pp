# Installs and configures PostgreSQL using PGDG packages.
#
# @example Basic Usage
#   include '::postgresql'
#
# @param [String] pgdg_name Name of PGDG PostgreSQL Yum repo package.
# @param [String] pgdg_rpm URL to RPM for installing PGDG PostgreSQL Yum repository.
# @param [String] major_version Major version for PGDG packages and directories.
# @param [String] listen_host Listen IP address for the PostgreSQL server.
# @param [String] allowed_subnet Subnet allowed to connect to the server.
class postgresql (
  $pgdg_name = 'pgdg-centos10',
  $pgdg_rpm = 'https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm',
  $major_version = '10',
  $listen_host = 'localhost',
  $allowed_subnet = undef,
){

  $package_prefix = "postgresql${major_version}"
  $bin_dir = "/usr/pgsql-${major_version}/bin"
  $data_dir = "/var/lib/pgsql/${major_version}/data"
  $setup_command = "$bin_dir/postgresql-${major_version}-setup initdb"
  $service_name = "postgresql-${major_version}"

  package { 'postgresql_repo':
    name     => "$pgdg_name",
    ensure   => 'present',
    source   => "$pgdg_rpm",
 }

  package { 'postgresql-server':
    name    => "$package_prefix-server",
    ensure  => 'present',
    require => Package['postgresql_repo'],
  }

  package { 'postgresql-contrib':
    name    => "$package_prefix-contrib",
    ensure  => 'present',
    require => Package['postgresql_repo'],
  }

  exec { 'postgresql-initdb':
    command => "$setup_command",
    creates => "$data_dir/PG_VERSION",
    user    => 'root',
    group   => 'root',
    require => Package['postgresql-server'],
  }

  file { 'pg_hba.conf':
    ensure  => file,
    path    => "$data_dir/pg_hba.conf",
    content => epp('postgresql/pg_hba.conf.epp'),
    owner   => 'postgres',
    group   => 'postgres',
    mode    => '0600',
    require => Exec['postgresql-initdb'],
    notify  => Service['postgresql'],
  }

  file { 'postgresql.conf':
    ensure  => file,
    path    => "$data_dir/postgresql.conf",
    content => epp('postgresql/postgresql.conf.epp'),
    owner   => 'postgres',
    group   => 'postgres',
    mode    => '0600',
    require => Exec['postgresql-initdb'],
    notify  => Service['postgresql'],
  }

  service { 'postgresql':
    name      => "$service_name",
    ensure    => running,
    enable    => true,
    subscribe => [Package['postgresql-server'], Exec['postgresql-initdb']],
  }

}
