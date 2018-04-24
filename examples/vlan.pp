# CNOS Vlan example

class cnos::vlan {
  ensure      => 'present',
  vlan_id     => 11,
  admin_state => 'up',
  vlan_name   => 'Vlan 11',
}
