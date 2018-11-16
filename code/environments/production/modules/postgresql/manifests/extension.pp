# Installs an extension into a database. The extension must exist on the
# server.
#
# @example Basic Usage
#   postgresql::extension { 'plpgsql':
#     database => 'mydb',
#   }
#
# @param [String] database Where to install the extension.
define postgresql::extension (
  String $database = undef,
) {

  exec { "postgresql-extension-$database-$title":
    command => "/bin/psql $database -tAc \"CREATE EXTENSION $title\"",
    user    => 'postgres',
    group   => 'postgres',
    unless => "/bin/psql $database -tAc \"SELECT 1 FROM pg_extension WHERE extname='$title'\" | grep -q 1",
  }

}
