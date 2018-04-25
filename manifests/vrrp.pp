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

# A VRRP creation/update/delete class for CNOS Devices.
#
# This is an example of how to create a VRRP
# If you change ensure to 'absent', it will delete the VRRP Configuration
# You can change various attributes associated with VRRP using this class
#
# @example Declaring the class
#   include cnos_vrrp
#
# @param [String] name vr_id and if_name as String
# @property [String] if_name Interface name.
# @property [Integer] vr_id Virtual Router (VR) identifier; an integer from 1-255.
# @property [String] ip_addr The IP address of the VR; a valid IPv4 address.
# @property [Integer] ad_intvl Advertisement interval in centi seconds.
# @property [String] preempt Enable the preemption of a lower priority master. yes or no
# @property [Integer] prio Priority of the VR on the switch.
# @property [String] admin_state Admin state of this vlan.
# @property [String] oper_state The operation state of the VR.
# @property [String] track_if The interface to track by this VR.
# @property [String] accept_mode Enables or disables the accept mode.
# @property [Integer] switch_back_delay The switch back delay interval.
# @property [String] v2_compt Enables backward compatibility for VRRPv2.


# @property [String] vlan_name Name of this vlan.

class cnos::vrrp (
  String $if_name,
  Integer $vr_id,
  String $ip_addr,
  Integer $ad_intvl,
  String $preempt,
  Integer $prio,
  String $admin_state,
  String $oper_status,
  String $track_if,
  String $accept_mode,
  Integer $switch_back_delay,
  String $v2_compt,
  String $vr_id_s = $title,
  Enum['present', 'absent'] $ensure  = 'present',
){
  cnos_vrrp{ $vr_id_s :
    ensure            => $ensure,
    prio              => $prio,
    vr_id             => $vr_id,
    if_name           => $if_name,
    preempt           => $preempt,
    admin_state       => $admin_state,
    ip_addr           => $ip_addr,
    switch_back_delay => $switch_back_delay,
    accept_mode       => $accept_mode,
    v2_compt          => $v2_compt,
    ad_intvl          => $ad_intvl,
  }
}
