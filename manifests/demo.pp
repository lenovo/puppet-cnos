# Copyright (c) 2017, Lenovo. All rights reserved.
#
# This program and the accompanying materials are licensed and made available
# under the terms and conditions of the 3-clause BSD License that accompanies 
# this distribution. The full text of the license may be found at

# https://opensource.org/licenses/BSD-3-Clause

# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, WITHOUT
# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.

cnos_lag { '100':
ensure => 'present',
interfaces =>  [ {
                "lacp_prio" => 32768,
                "lacp_timeout"=> "long",
                "lag_mode"=> "no_lacp",
                "if_name"=> "Ethernet1/1"
                },
                {
                "lacp_prio" => 32768,
                "lacp_timeout"=> "long",
                "lag_mode"=> "no_lacp",
                "if_name"=> "Ethernet1/2"
                }
                ],
}
cnos_lag { '20':
ensure => 'present',
interfaces =>  [ {
                "lacp_prio" => 32768,
                "lacp_timeout"=> "long",
                "lag_mode"=> "no_lacp",
                "if_name"=> "Ethernet1/9"
                },
                {
                "lacp_prio" => 32768,
                "lacp_timeout"=> "long",
                "lag_mode"=> "no_lacp",
                "if_name"=> "Ethernet1/10"
                }
                ],
}
cnos_lag { '10':
ensure => 'present',
interfaces =>  [ {
                "lacp_prio" => 32768,
                "lacp_timeout"=> "long",
                "lag_mode"=> "no_lacp",
                "if_name"=> "Ethernet1/17"
                },
                {
                "lacp_prio" => 32768,
                "lacp_timeout"=> "long",
                "lag_mode"=> "no_lacp",
                "if_name"=> "Ethernet1/18"
                }
                ],
}

cnos_vlag_conf{'vlag_conf':
tier_id => 10,
ensure => present
}
cnos_vlag_isl {'vlag_isl':
port_aggregator => 100
}

cnos_vlag { '1':
ensure => 'present',
status => 'enable',
port_aggregator => 10,}

cnos_vlag { '2':
ensure => 'present',
status => 'enable',
port_aggregator => 20,}

cnos_vlan_intf { 'po10':
bridgeport_mode => 'trunk',
pvid => 1,
vlans => [20,21],}

cnos_vlan_intf { 'po20':
bridgeport_mode => 'trunk',
pvid => 1,
vlans => [20,21],}

cnos_vlan_intf { 'po100':
bridgeport_mode => 'trunk',
pvid => 1,
vlans => [20,21],}

cnos_vlan { '20':
ensure => 'present',
admin_state => 'up',
vlan_name => 'test20',}

cnos_vlan { '21':
ensure => 'present',
admin_state => 'up',
vlan_name => 'test21',}

