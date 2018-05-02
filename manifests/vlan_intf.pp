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

# This class provides associating of interface with vlans
#
# @example Declaring the class
#   include cnos_vlan_intf
#
# @param [String] if_name Ethernet interface name.
# @property [String] if_name Ethernet interface name.
# @property [String] bridgeport_mode Bridge Port mode has to be either 'access' or trunk.
# @property [Integer] pvid The Native VLAN ID for switch ports.
# @property [Array] vlans It has to be an array of vlan id or the string 'all' or 'none'.

class cnos::vlan_intf (
  String $bridgeport_mode,
  Integer $pvid,
  Array $vlans,
  String $if_name = $title,
  Enum['present', 'absent'] $ensure  = 'present',
){
  cnos_vlan_intf { $if_name :
    ensure          => $ensure,
    if_name         => $if_name,
    bridgeport_mode => $bridgeport_mode,
    pvid            => $pvid,
    vlans           => $vlans,
  }
}
