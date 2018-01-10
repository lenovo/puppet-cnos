cnos_lag { '100':
ensure => 'present',
interfaces =>  [ {
                "lag_mode"=> "no_lacp",
                "if_name"=> "Ethernet1/1"
                },
                {
                "lag_mode"=> "no_lacp",
                "if_name"=> "Ethernet1/2"
                }
                ],
min_links => 4,
}
cnos_lag { '20':
ensure => 'present',
interfaces =>  [ {
                "lag_mode"=> "no_lacp",
                "if_name"=> "Ethernet1/9"
                },
                {
                "lag_mode"=> "no_lacp",
                "if_name"=> "Ethernet1/10"
                }
                ],
}
cnos_lag { '10':
ensure => 'present',
interfaces =>  [ {
                "lag_mode"=> "no_lacp",
                "if_name"=> "Ethernet1/17"
                },
                {
                "lag_mode"=> "no_lacp",
                "if_name"=> "Ethernet1/18"
                }
                ],
}

