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
		     port_aggregator => <port_aggregator>,
		     status => enable/disable,
             }
           }'
  ensurable

  # Parameters
  newparam(:inst_id, namevar: true) do
    desc 'inst_id an integer from 2-3999'

    validate do |value|
      unless value.to_i.between?(1, 64)
        fail "value not within limit (1-64)"
      end
    end
  end

  # Properties
  newproperty(:port_aggregator) do
    desc 'string 32 characters long'

    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(1, 4096)
        fail "value not within limit (1-4096)"
      end
    end
  end

  newproperty(:status) do
    desc 'one of up or down'
    #  newvalues('enable', 'disable')
  end
end
