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

Puppet::Type.newtype(:cnos_arp) do
  desc 'Manage ARP properties on Lenovo CNOS Switches.'

  apply_to_device
  ensurable

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

  newproperty(:ageout_time) do
    desc 'integer from 60-28800'

    validate do |value|
      raise 'value not within limit (60-28800)' unless value.to_i.between?(60, 28_800)
    end
    munge(&:to_i)
  end
end
