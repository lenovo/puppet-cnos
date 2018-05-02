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

# This class provides setting of telemetry feature in a CNOS switch
#
# @example Declaring the class
#   include cnos_sys
#
# @param [String] name Its defined as sys.
# @property [Integer] msg_interval The interval with which heartbeat messages sent.
# @property [Integer] heartbeat_enable The value is 0/1 for enable or disable

class cnos::sys (
  Integer $msg_interval,
  Integer $heartbeat_enable,
  String $feature_name = 'sys',
  Enum['present', 'absent'] $ensure  = 'present',
){
  cnos_sys{ $feature_name :
    ensure           => $ensure,
    msg_interval     => $msg_interval,
    heartbeat_enable => $heartbeat_enable,
  }
}
