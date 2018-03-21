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

Puppet::Type.newtype(:cnos_vlan_intf) do
  desc ' = {
            Manage Vlan_intf on Lenovo cnos.

            Example:
             cnos_vlan_intf {"<if_name>":
                     bridgeport_mode => access/trunk,
                     pvid => "<pvid>",
                     vlans => ["<vlan_id>"]
              }
           }'

  ensurable
  apply_to_device

  # Parameters
  newparam(:if_name, namevar: true) do
    desc 'Ethernet interface name'
  end

  # Properties
  newproperty(:bridgeport_mode) do
    newvalues(:access, :trunk)
    desc 'one of access/trunk'
  end

  newproperty(:pvid) do
    desc 'integer from 1-3999'

    munge(&:to_i)
  end

  newproperty(:vlans, array_matching: :all) do
    desc 'VLAN memberships'
  end
end
