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

# This class is used in configurations of VLAG Health Check parameters
#
# @example Declaring the class
#   include cnos_vlag_hc
#
# @param [String] feature_name The string vlag_health.
# @property [String] status Whether the vLAG is enabled or disabled.
# @property [Integer] keepalive_interval Time interval, in seconds.
# @property [Integer] retry_interval Time interval, in seconds.
# @property [Integer] keepalive_attempts Number of keepalive attempts before declaring peer down.

class cnos::vlag_health (
  String $status,
  Integer $keepalive_interval,
  Integer $retry_interval,
  Integer $keepalive_attempts,
  String $feature_name = $title,
  Enum['present', 'absent'] $ensure  = 'present',
){
  cnos_vlag_hc { $feature_name :
    ensure             => $ensure,
    keepalive_interval => $keepalive_interval,
    retry_interval     => $retry_interval,
    keepalive_attempts => $keepalive_attempts,
  }
}
