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
# This is an example of how to create a vlan
# If you change ensure to 'absent', it will delete the vlan
# You can change vlan_name and admin_state of a device using this class
#
# @example Declaring the class
#   include cnos_vlan
#
# @param [String] name Vlan id of the Vlan.
# @property [Integer] vlan_id Vlan id of the Vlan.
# @property [String] admin_state Admin state of this vlan.
# @property [String] vlan_name Name of this vlan.

class cnos::vlan {
  cnos_vlan { '11':
    ensure      => 'present',
    vlan_id     => 11,
    admin_state => 'down',
    vlan_name   => 'test11',
  }
}
