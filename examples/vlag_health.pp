# CNOS VLAG Health example

cnos_vlag_hc { 'vlag_health' :
  ensure             => 'absent',
  keepalive_interval => 5,
  retry_interval     => 10,
  keepalive_attempts => 15,
}
