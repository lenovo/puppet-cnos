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

class cnos::vlan_demo {
  cnos_vlan { '20':
    ensure      => 'present',
    admin_state => 'up',
    vlan_name   => 'test20',
  }

  cnos_vlan { '21':
    ensure      => 'present',
    admin_state => 'up',
    vlan_name   => 'test21',
  }
}

