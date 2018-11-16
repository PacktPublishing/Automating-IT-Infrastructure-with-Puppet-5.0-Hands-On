# Creates a user.
#
# @example Basic Usage
#   postgresql::user { 'newuser':
#     password => 'supersecret',
#   }
#
# @param [String] password User password.
define postgresql::user (
  String $password = undef,
) {

  exec { "postgresql-user-$title":
    command => "/bin/psql -tAc \"CREATE ROLE $title WITH LOGIN PASSWORD '$password'\"",
    user    => 'postgres',
    group   => 'postgres',
    unless => "/bin/psql -tAc \"SELECT 1 FROM pg_roles WHERE rolname='$title'\" | grep -q 1",
  }

}
