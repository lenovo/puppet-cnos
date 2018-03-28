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

# A LAG creation/update/delete class for CNOS Devices.
#
# This is an example of how to create a LAG
# If you change ensure to 'absent', it will delete the LAG Configuration
# You can change various attributes associated with LAG using this class
#
# @example Declaring the class
#   include cnos_lag
#
# @param [String] name lag_id as String
# @property [String] lag_id LAG identifier; an integer from 1-65535
# @property [Integer] min_links LACP minimum links number; an integer from 1-32
# @property [Integer] lacp_prio LACP priority for the physical port
# @property [String] lacp_timeout LACP timeout for the physical port.
# @property [String] lag_mode LAG mode; one of lacp_active, lacp_passive, no_lacp.
# @property [String] if_name Ethernet interface name.


class cnos::lag {
  cnos_lag { '11':
    ensure     => 'present',
    interfaces =>  [ {
      'lacp_prio'    => 32768,
      'lacp_timeout' => 'long',
      'lag_mode'     => 'lacp_active',
      'if_name'      => 'Ethernet1/23',
    }],
    lag_id     => 11,
    min_links  => 2,
  }
}
