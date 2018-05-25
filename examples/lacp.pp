# CNOS LACP example

cnos_lacp { 'sys_prio' :
  ensure   => 'present',
  sys_prio => '32769',
}
