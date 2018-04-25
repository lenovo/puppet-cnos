# CNOS Vlag example

class cnos::vlag {
  cnos_vlag { '2':
    inst_id         => 2,
    ensure          => 'present',
    status          => 'disable',
    port_aggregator => 20,
  }
}
