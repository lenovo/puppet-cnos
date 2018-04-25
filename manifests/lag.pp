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
# You can configure only min_links and lag_id attributes 
# associated with LAG using this class. More LAG attributes will be
# supported in furture releases
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


class cnos::lag (
  Integer $min_links,
  Integer $lacp_prio,
  String $lacp_timeout,
  String $lag_mode,
  String $if_name,
  Enum['present', 'absent'] $ensure  = 'present',
  String $lag_id = $title,
){
  cnos_lag { $lag_id:
    ensure     => $ensure,
    interfaces =>  [ {
      'lacp_prio'    => $lacp_prio,
      'lacp_timeout' => $lacp_timeout,
      'lag_mode'     => $lag_mode,
      'if_name'      => $if_name,
    }],
    lag_id     => $lag_id
    min_links  => $min_links,
  }
}
