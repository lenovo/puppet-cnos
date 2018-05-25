# CNOS Vlag example

cnos_vlag { '2' :
  ensure          => 'present',
  inst_id         => 2,
  status          => 'disable',
  port_aggregator => 20,
}
