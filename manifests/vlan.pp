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

cnos_vlan { '11':
ensure => 'present',
admin_state => 'down',
vlan_name => 'test11',}
