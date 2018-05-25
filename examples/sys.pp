# CNOS BST System example

cnos_sys{ 'sys' :
  ensure           => present,
  msg_interval     => 15,
  heartbeat_enable => 1,
}
