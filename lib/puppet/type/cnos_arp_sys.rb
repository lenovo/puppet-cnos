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

Puppet::Type.newtype(:cnos_arp_sys) do
  desc ' = {
 	    Manage Arp Sys on Lenovo cnos.

 	    Example:
 	      cnos_arp_sys{"arp_sys":
			    ageout_time => ageout_time
              }
           }'

  # Parameters
  newparam(:title, namevar: true) do
    desc 'name of parameter'
  end

  # Properties
  newproperty(:ageout_time) do
    desc 'integer from 60-28800'

    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(60, 28800)
        fail "value not within limit (60-28800)"
      end
    end
  end
end
