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

# This class provides mapping of interface with vlan
#
# This is an example of how to make this association
# Both the interface and the vlans has to be present for this association.
# If you change ensure to 'absent', it will dissociate from all vlan
# You can change all the parameters of this association using this class
#
# @example Declaring the class
#   include cnos_vlan_intf
#
# @param [String] Ethernet interface name.
# @property if_name [String] Ethernet interface name.
# @property bridgeport_mode [String] Bridge Port mode has to be either 'access' or trunk.
# @property pvid [Integer] The Native VLAN ID for switch ports.
# @property vlans [Array] It has to be an array of vlan id or the string 'all' or 'none'.

class cnos::vlan_intf {
  cnos_vlan_intf { 'Ethernet1/92':
    ensure          => 'present',
    if_name         => 'Ethernet1/92',
    bridgeport_mode => 'trunk',
    pvid            => 1,
    vlans           => [10],
  }
}
