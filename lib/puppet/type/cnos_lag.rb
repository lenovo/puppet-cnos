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

Puppet::Type.newtype(:cnos_lag) do
  desc ' = {
 	    Manage lags on Lenovo cnos.

 	    Example:
 	     cnos_lag {"<lag_id>":
                       "interfaces": [
 		        {
			    "if_name": "<if_name>",
			    "lag_mode": "<lag_mode>",
			    "lacp_prio": "<lacp_prio>",
			    "lacp_timeout": "<lacp_timeout>"
              		}
 		       ]
        	    }
           }'
  apply_to_device
  ensurable

  # Parameters
  newparam(:lag_id, namevar: true) do
    desc 'lag_id an integer from 1-4096'

    munge(&:to_i)

    validate do |value|
      raise 'value not within limit (1-4096)' unless value.to_i.between?(1, 4096)
    end
  end

  # Properties
  newproperty(:interfaces, array_matching: :all) do
    desc 'array of interfaces dictionary'
    #     def insync?(current)
    #       current.sort == should.sort
    #     end
  end

  newproperty(:min_links) do
    desc 'lag_id an integer from 1-4096'

    munge(&:to_i)

    validate do |value|
      unless value.to_i.between?(1, 65_535)
        raise 'value not within limit (1-65535)'
      end
    end
  end
end
