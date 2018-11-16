# Installs and configures OpenJDK.
#
# @example Basic Usage
#   include '::java'
#
# @param [String] major_version The major Java version (e.g. 1.8.0).
# @param [String] version The package version (e.g. latest).
class java (
  $major_version = '1.8.0',
  $version = 'latest',
) {

  package { "java-${major_version}-openjdk":
    ensure => $version,
  }
}
