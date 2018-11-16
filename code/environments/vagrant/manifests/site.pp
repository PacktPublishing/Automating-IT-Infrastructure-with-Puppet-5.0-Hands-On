$defaults = {
  'ensure' => present,
}
create_resources(host, parsejson($facts['hosts']), $defaults)
