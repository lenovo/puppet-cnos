cnos_vlag_conf{'vlag_conf':
tier_id => 10,
ensure => present
}
cnos_vlag_isl {'vlag_isl':
port_aggregator => 100
}

cnos_vlag { '1':
ensure => 'present',
status => 'enable',
port_aggregator => 10,}

cnos_vlag { '2':
ensure => 'present',
status => 'enable',
port_aggregator => 20,}
