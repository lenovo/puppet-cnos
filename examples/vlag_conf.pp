# CNOS Vlag Configuration example

class cnos::vlag_conf {
  cnos_vlag_conf{'vlag_conf':
    ensure        => 'present',
    status        => 'enable',
    tier_id       => 10,
    priority      => 33,
    auto_recover  => 313,
    startup_delay => 133,
  }
}
