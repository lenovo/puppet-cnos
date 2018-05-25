# CNOS LAG example

cnos_lag { '11' :
  ensure     => 'present',
  interfaces =>  [ {
    'lacp_prio'    => 32768,
    'lacp_timeout' => 'long',
    'lag_mode'     => 'lacp_active',
    'if_name'      => 'Ethernet1/23',
  }],
  lag_id     => 11,
  min_links  => 2,
}
