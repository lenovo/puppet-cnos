# CNOS Vlan example

class cnos::vlan {
  cnos_vlan { 'Vlan 11':
    ensure      => 'present',
    vlan_id     => 11,
    admin_state => 'up',
    vlan_name   => 'Vlan 11',
  }
}
