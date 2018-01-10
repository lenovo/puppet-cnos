cnos_lag { '11':
ensure => 'present',
interfaces =>  [ {
                "lacp_prio" => 32768,
                "lacp_timeout"=> "long",
                "lag_mode"=> "lacp_active",
                "if_name"=> "Ethernet1/23"
            }],
min_links => 2,
}
