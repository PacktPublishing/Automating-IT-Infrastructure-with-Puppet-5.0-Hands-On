# Creates a database.
#
# @example Basic Usage
#   postgresql::database { 'newdb':
#     owner => 'myuser',
#   }
#
# @param [String] owner Database owner. Must exist as a PostgreSQL user.
# @param [String] encoding Database encoding.
define postgresql::database (
  String $owner = undef,
  String $encoding = 'UTF-8',
) {

  exec { "postgresql-database-$title":
    command => "/bin/createdb -E $encoding -O $owner $title",
    user    => 'postgres',
    group   => 'postgres',
    unless => "/bin/psql -tAc \"SELECT 1 FROM pg_database WHERE datname='$title'\" | grep -q 1",
  }

}
