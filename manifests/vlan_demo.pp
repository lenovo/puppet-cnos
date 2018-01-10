cnos_vlan { '20':
ensure => 'present',
admin_state => 'up',
vlan_name => 'test20',}

cnos_vlan { '21':
ensure => 'present',
admin_state => 'up',
vlan_name => 'test21',}
