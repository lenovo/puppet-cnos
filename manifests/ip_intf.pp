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
# This is an example of how to make this association
# The interface must exist for this association.
# If you change ensure to 'absent', it will just change mtu and bridge_port 
# to default values. There is no delete method for this association
# You can change all the parameters of this association using this class
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
class cnos::ip_intf {
  cnos_ip_intf{'Ethernet1/11':
    ensure        => present,
    ip_addr       => '1.1.1.1',
    bridge_port   => 'no',
    if_name       => 'Ethernet1/11',
    mtu           => 1502,
    vrf_name      => 'default',
    admin_state   => 'up',
    ip_prefix_len => 24
  }
}
