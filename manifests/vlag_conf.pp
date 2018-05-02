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

# This class is used in configurations of VLAG
#
# @example Declaring the class
#   include cnos_vlag_conf
#
# @param [String] name The string vlag_conf.
# @property [String] status Whether the vLAG is enabled or disabled.
# @property [Integer] tier_id vLAG tier ID value. An intger from 1-512. Default value: 0.
# @property [Integer] priority VLAG priority value, an integer from 0-65535. Default value: 0.
# @property [Integer] auto_recover Time interval, in seconds; an integer from 240-3600. Default 300
# @property [Integer] startup_delay Delay time, in seconds; an integer from 0-3600. Default 120.

class cnos::vlag_conf (
  String $status,
  Integer $tier_id = 0,
  Integer $priority = 0,
  Integer $auto_recover = 300,
  Integer $startup_delay = 120,
  String $feature_name = $title,
  Enum['present', 'absent'] $ensure  = 'present',
){
  cnos_vlag_conf{ $feature_name :
    ensure        => $ensure,
    status        => $status,
    tier_id       => $tier_id,
    priority      => $priority,
    auto_recover  => $auto_recover,
    startup_delay => $startup_delay,
  }
}
