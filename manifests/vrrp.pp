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

class cnos::vrrp {
  cnos_vrrp{ '1' :
    ensure            => present,
    prio              => 100,
    vr_id             => 1,
    if_name           => 'Ethernet1/11',
    preempt           => 'no',
    admin_state       => 'down',
    ip_addr           => '1.1.1.25',
    switch_back_delay => 1,
    accept_mode       => 'no',
    v2_compt          => 'no',
    ad_intvl          => 100,
  }
}
