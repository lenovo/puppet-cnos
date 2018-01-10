cnos_vlan { '10':
ensure => 'present',
admin_state => 'down',
vlan_name => 'test10',}

cnos_vlan { '11':
ensure => 'present',
admin_state => 'up',
vlan_name => 'test11',}
