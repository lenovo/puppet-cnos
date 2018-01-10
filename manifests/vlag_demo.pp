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

cnos_vlag_conf{'vlag_conf':
tier_id => 10,
ensure => present
}
cnos_vlag_isl {'vlag_isl':
port_aggregator => 100
}

cnos_vlag { '1':
ensure => 'present',
status => 'enable',
port_aggregator => 10,}

cnos_vlag { '2':
ensure => 'present',
status => 'enable',
port_aggregator => 20,}
