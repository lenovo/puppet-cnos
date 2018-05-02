# Copyright (c) 2018, Lenovo. All rights reserved.
#
# This program and the accompanying materials are licensed and made available
# under the terms and conditions of the 3-clause BSD License that accompanies 
# this distribution. The full text of the license may be found at
#
# https://opensource.org/licenses/BSD-3-Clause
#
# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, WITHOUT
# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.

# A Vlan creation/update/delete class for CNOS Devices.
#
# @example Declaring the class
#   include cnos_vlan
#
# @param [String] name Vlan id of the Vlan.
# @property [Integer] vlan_id Vlan id of the Vlan.
# @property [String] admin_state Admin state of this vlan.
# @property [String] vlan_name Name of this vlan.

class cnos::vlan (
  Integer $vlan_id,
  Enum['present', 'absent'] $ensure  = 'present',
  String  $admin_state = 'up',
  String  $vlan_name   = $title,
){
  cnos_vlan { $vlan_name :
    ensure      => $ensure,
    vlan_id     => $vlan_id,
    admin_state => $admin_state,
    vlan_name   => $vlan_name,
  }
}
