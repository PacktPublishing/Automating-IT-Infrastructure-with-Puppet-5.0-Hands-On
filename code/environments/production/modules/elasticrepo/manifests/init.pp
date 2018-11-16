# Configures the Elasticsearch repository. Used by
# Elasticsearch, Kibana, and Logstash.
#
# @example Basic Usage
#   include '::elasticrepo'
#
# @param [String] major_version The major version (e.g. 6.x).
class elasticrepo (
  $major_version = '6.x',
) {

  yumrepo { 'elasticsearch':
    ensure   => 'present',
    baseurl  => "https://artifacts.elastic.co/packages/${major_version}/yum",
    enabled  => 1,
    descr    => 'Elasticsearch repository for packages',
    gpgcheck => 1,
    gpgkey   => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
  }

}
