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

# This class provides setting of VLAG Instance configurations
#
# @example Declaring the class
#   include cnos_vlag_isl
#
# @param [String] feature_name Its defined as vlag_isl.
# @property [Integer] msg_interval The interval with which heartbeat messages sent.
# @property [Integer] port_aggregator LAG identifier; an integer from 1-4096.

class cnos::vlag_isl (
  Integer $msg_interval,
  Integer $port_aggregator,
  String $feature_name = $title,
  Enum['present', 'absent'] $ensure  = 'present',
){
  cnos_vlag_isl { $feature_name :
    ensure          => $ensure,
    port_aggregator => $port_aggregator,
    msg_interval    => $msg_interval,
  }
}
