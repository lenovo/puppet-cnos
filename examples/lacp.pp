# CNOS LACP example

class cnos::lacp {
  cnos_lacp {'sys_prio':
    ensure   => 'present',
    sys_prio => '32769',
  }
}
