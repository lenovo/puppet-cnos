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
  desc 'Manage Vlan_intf on Lenovo CNOS Switches.'

  ensurable
  apply_to_device

  # Parameters
  newparam(:name, namevar: true) do
    desc 'Ethernet interface name'

    validate do |value|
      super value
      raise('the name must be string representation of interface name') if value.size > 64
    end
  end

  # Properties
  newproperty(:if_name) do
    desc 'Ethernet interface name'

    validate do |value|
      super value
      raise('the name must be string representation of interface name') if value.size > 64
    end
  end
  newproperty(:bridgeport_mode) do
    newvalues(:access, :trunk)
    desc 'one of access/trunk'
    validate do |value|
      super value
      raise('the name must be string representation of bridgeport mode') if value != 'access' && value != 'trunk'
    end
  end

  newproperty(:pvid) do
    desc 'integer from 1-3999'

    validate do |value|
      raise 'value not within limit (1-3999)' unless value.to_i.between?(1, 3999)
    end
    munge(&:to_i)
  end

  newproperty(:vlans, array_matching: :all) do
    desc 'VLAN memberships'
  end
end
