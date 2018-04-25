# CNOS IP Interface example

class cnos::ip_intf {
  cnos_ip_intf{'Ethernet1/11':
    ensure        => present,
    ip_addr       => '1.1.1.1',
    bridge_port   => 'no',
    if_name       => 'Ethernet1/11',
    mtu           => 1502,
    vrf_name      => 'default',
    admin_state   => 'up',
    ip_prefix_len => 24
  }
}
