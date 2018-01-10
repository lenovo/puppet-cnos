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

cnos_ip_intf{'Ethernet1/1':
   ensure => 'present', 
   ip_addr => "1.1.1.1",
   bridge_port => "no",
   if_name => "Ethernet1/1",
   mtu => 1502,
   vrf_name => "default",
   admin_state => "up",
   ip_prefix_len => 24
}
