# Copyright (c) 2017, Lenovo. All rights reserved.
#
# This program and the accompanying materials are licensed and made available
# under the terms and conditions of the 3-clause BSD License that accompanies 
# this distribution. The full text of the license may be found at

# https://opensource.org/licenses/BSD-3-Clause

# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, WITHOUT
# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.

# This class provides setting of ageout time for arp for an interface
#
# @example Declaring the class
#   include cnos_arp
#
# @param [String] name Ethernet interface name.
# @property [Integer] ageout_time The global ARP entry age-out time, in seconds.

class cnos::arp (
  Integer $ageout_time,
  String $interface_name = $title,
  Enum['present', 'absent'] $ensure  = 'present',
){
  cnos_arp{ $interface_name :
    ensure      => $ensure,
    if_name     => $interface_name,
    ageout_time => $ageout_time,
  }
}
