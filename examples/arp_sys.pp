# CNOS ARP System example

class cnos::arp_sys {
  cnos_arp_sys{'arp_sys':
    ensure      => 'present',
    ageout_time => 1000
  }
}
