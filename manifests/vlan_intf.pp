cnos_vlan_intf { 'Ethernet1/92':
#ensure => 'present',
bridgeport_mode => 'trunk',
pvid => 1,
vlans => [10],}
