cnos_vlan_intf { 'po10':
bridgeport_mode => 'trunk',
pvid => 1,
vlans => [20,21],}

cnos_vlan_intf { 'po20':
bridgeport_mode => 'trunk',
pvid => 1,
vlans => [20,21],}

cnos_vlan_intf { 'po100':
bridgeport_mode => 'trunk',
pvid => 1,
vlans => [20,21],}
