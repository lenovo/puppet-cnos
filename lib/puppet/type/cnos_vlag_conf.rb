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

Puppet::Type.newtype(:cnos_vlag_conf) do
  desc ' = {
 	    Manage Vlag Health on Lenovo cnos.

 	    Example:
 	     cnos_vlag_conf {"vlag_conf":
                     
		  "status": "<status>",
		  "tier_id": "<tier_id>",
		  "priority": "<priority>",
		  "auto_recover" : "<auto_recover>",
		  "startup_delay": "<startup_delay>",

                }
           }'
  ensurable

  # Parameters
  newparam(:title, namevar: true) do
    desc 'name of parameter'
  end

  # Properties
  newproperty(:status) do
    desc 'status'
  end

  newproperty(:tier_id) do
    desc 'tier_id'
    
    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(1, 512)
        fail "value not within limit (1-512)"
      end
    end
  end

  newproperty(:priority) do
    desc 'priority'

    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(0, 65535)
        fail "value not within limit (0-65535)"
      end
    end
  end

  newproperty(:auto_recover) do
    desc 'auto recover'

    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(240, 3600)
        fail "value not within limit (240-3600)"
      end
    end
  end

  newproperty(:startup_delay) do
    desc 'startup_delay'

    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(0, 3600)
        fail "value not within limit (0-3600)"
      end
    end
  end
end
