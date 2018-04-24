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
# This is an example of how to make this timeout value to set
# If you change ensure to 'absent', it will reset this value to factory default
# The default value is 1500
#
# @example Declaring the class
#   include cnos_arp
#
# @param [String] name Is set as arp_sys
# @property [Integer] ageout_time The global ARP entry age-out time, in seconds.

class cnos::arp_sys {
  cnos_arp_sys{'arp_sys':
    ensure      => 'present',
    ageout_time => 1000,
  }
}
