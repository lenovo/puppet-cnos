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

# This class provides setting of LACP system priority for all interfaces
#
# @example Declaring the class
#   include cnos_lacp
#
# @property [Integer] sys_prio LACP system priority, a positive integer from 1-65535.

class cnos::lacp (
  Integer $sys_prio = 32768,
  String $feature_name = 'sys_prio',
  Enum['present', 'absent'] $ensure  = 'present',
){
  cnos_lacp { $feature_name :
    ensure   => $ensure,
    sys_prio => $sys_prio,
  }
}
