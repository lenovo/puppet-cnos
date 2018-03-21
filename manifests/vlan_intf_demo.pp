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

class cnos::vlan_intf_demo {
  cnos_vlan_intf { 'po10':
    bridgeport_mode => 'trunk',
    pvid            => 1,
    vlans           => [20,21],
  }

  cnos_vlan_intf { 'po20':
    bridgeport_mode => 'trunk',
    pvid            => 1,
    vlans           => [20,21],
  }

  cnos_vlan_intf { 'po100':
    bridgeport_mode => 'trunk',
    pvid            => 1,
    vlans           => [20,21],
  }
}
