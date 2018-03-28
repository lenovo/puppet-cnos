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

Puppet::Type.newtype(:cnos_vlag) do
  desc ' = {
 	    Manage Vlags on Lenovo cnos.

 	    Example:
 	     cnos_vlag {1:
                     inst_id         => <inst_id>,
		     port_aggregator => <port_aggregator>,
		     status          => enable/disable,
             }
           }'
  apply_to_device
  ensurable

  # Parameters
  newparam(:name, namevar: true) do
    desc 'inst_id an integer from 1-64'

    validate do |value|
      raise 'value not within limit (1-64)' unless value.to_i.between?(1, 64)
    end
  end

  # Properties
  newproperty(:inst_id) do
    desc 'inst_id an integer from 1-64'

    validate do |value|
      raise 'value not within limit (1-64)' unless value.to_i.between?(1, 64)
    end
  end

  newproperty(:port_aggregator) do
    desc 'string 32 characters long'

    munge(&:to_i)

    validate do |value|
      raise 'value not within limit (1-4096)' unless value.to_i.between?(1, 4096)
    end
  end

  newproperty(:status) do
    desc 'one of enable or disable'
    validate do |value|
      super value
      raise('the name must be string representation of bridgeport mode') if value != 'enable' && value != 'disable'
    end
  end
end
