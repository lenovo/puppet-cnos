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

# This class provides setting of ageout time for arp for the system
#
# @example Declaring the class
#   include cnos_arp
#
# @param [String] name Is set as arp_sys
# @property [Integer] ageout_time The global ARP entry age-out time, in seconds.

class cnos::arp_sys (
  Integer $ageout_time,
  Enum['present', 'absent'] $ensure  = 'present',
  String $system = $title,
){
  cnos_arp_sys{ $system :
    ensure      => $ensure,
    ageout_time => $ageout_time,
  }
}

