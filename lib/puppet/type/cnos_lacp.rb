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

Puppet::Type.newtype(:cnos_lacp) do
  desc ' = {
 	    Manage Lacp on Lenovo cnos.

 	    Example:
 	     cnos_lacp {"lacp":
		      sys_prio => <sys_prio>
              }
           }'

  # Parameters
  newparam(:title, namevar: true) do
    desc 'name of parameter'
  end

  # Properties
  newproperty(:sys_prio) do
    desc 'integer from 1-65535'

    munge(&:to_i)

    validate do |value|
      unless value.to_i.between?(1, 65535)
        raise 'value not within limit (1-65535)'
      end
    end
  end
end
