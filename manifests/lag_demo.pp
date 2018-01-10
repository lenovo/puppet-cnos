# Copyright (c) 2017, Lenovo. All rights reserved.
#
# This program and the accompanying materials are licensed and made available
# under the terms and conditions of the 3-clause BSD License that accompanies 
# this distribution. The full text of the license may be found at
#
# https://opensource.org/licenses/BSD-3-Clause
#
# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, WITHOUT
# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.

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

