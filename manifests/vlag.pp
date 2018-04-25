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

# A VLAG creation/update/delete class for CNOS Devices.
#
# This is an example of how to create a VLAG Instance.
# If you change ensure to 'absent', it will delete the vlag instance
# You can change status and port_aggregator values of a vlag instance.
#
# @example Declaring the class
#   include cnos_vlag
#
# @param [String] name Vlag instance id as string.
# @property [Integer] inst_id Vlag instance id.
# @property [String] status VLAG status, one of enable, disable.
# @property [String] port_aggregator LAG identifier; an integer from 1-4096.

class cnos::vlag (
  String $status,
  String $port_aggregator,
  Enum['present', 'absent'] $ensure  = 'present',
  String $inst_id = $title,
){
  cnos_vlag { $inst_id:
    inst_id         => $inst_id,
    ensure          => $ensure,
    status          => $status,
    port_aggregator => $port_aggregator,
  }
}
