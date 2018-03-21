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

Puppet::Type.newtype(:cnos_vlan) do
  desc ' = {
            Manage Vlans on Lenovo cnos.
            Example:
             cnos_vlan {1:
                     vlan_name => vlan1,
                     admin_state => up,
              }
           }'
  apply_to_device
  ensurable

  # Parameters
  newparam(:name, namevar: true) do
    desc 'Name of VLAN.'

    validate do |value|
      super value
      raise('the name must be between 1 and 64 characters long') if value.size > 64
    end
  end

  # Properties
  newproperty(:vlan_id) do
    desc 'vlan_id an integer from 1-3999'

    validate do |value|
      raise 'value not within limit (2-3999)' unless value.to_i.between?(1, 3999)
    end
  end

  newproperty(:vlan_name) do
    desc 'string 32 characters long'
  end

  newproperty(:admin_state) do
    desc 'one of up or down'
  end
end
