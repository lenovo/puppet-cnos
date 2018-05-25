# CNOS Vlag Configuration example

cnos_vlag_conf{' vlag_conf' :
  ensure        => 'present',
  status        => 'enable',
  tier_id       => 10,
  priority      => 33,
  auto_recover  => 313,
  startup_delay => 133,
}
