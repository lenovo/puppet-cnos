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

# This class provides ip interface association
#
# @example Declaring the class
#   include cnos_ip_intf
#
# @param [String] name Ethernet interface name.
# @property [String] if_name Ethernet interface name. The interface must exist.
# @property [String] ip_addr IP address for the interface.
# @property [String] bridge_port Whether or not the port is a bridge port
# @property [Integer] mtu The maximum transmission unit, in bytes
# @property [String] vrf_name The name of the VRF to which the interface belongs.The named VRF must exist.
# @property [Integer] ip_prefix_len IP address mask, a positive integer from 1-32.
# @property [String] admin_state The admin status; one of up, down.
class cnos::ip_intf (
  String $if_name,
  String $ip_addr,
  String $bridge_port,
  Integer $mtu,
  String $vrf_name,
  Integer $ip_prefix_len,
  String  $admin_state = 'up',
  Enum['present', 'absent'] $ensure  = 'present',
  String $eth_name   = $title,
){
  cnos_ip_intf{ $eth_name :
    ensure        => $ensure,
    ip_addr       => $ip_addr,
    bridge_port   => $bridge_port,
    if_name       => $if_name,
    mtu           => $mtu,
    vrf_name      => $vrf_name,
    admin_state   => $admin_state,
    ip_prefix_len => $ip_prefix_len,
  }
}
