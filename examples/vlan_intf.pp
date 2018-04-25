# CNOS Vlan Interface example

class cnos::vlan_intf {
  cnos_vlan_intf { 'Ethernet1/92':
    ensure          => 'present',
    if_name         => 'Ethernet1/92',
    bridgeport_mode => 'trunk',
    pvid            => 1,
    vlans           => [10],
  }
}
