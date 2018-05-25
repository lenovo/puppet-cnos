# CNOS ARP System example

cnos_arp_sys{ 'arp_sys' :
  ensure      => 'present',
  ageout_time => 1000,
}
