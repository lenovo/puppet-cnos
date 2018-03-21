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

Puppet::Type.newtype(:cnos_ip_intf) do
  desc ' = {
 	    Manage Ip intf on Lenovo cnos.

 	    Example:
 	     cnos_ip_intf{"<if_name>":
 	                  bridge_port => yes/no,
		          mtu => "<mtu>",
		          ip_addr => "<ip_addr>",
		          ip_prefix_len => "<ip_prefix_len>",
		          vrf_name => "<vrf_name>",
		          vlans => "<admin_state>"
        	         }
           }'
  apply_to_device
  ensurable

  # Parameters
  newparam(:if_name, namevar: true) do
    desc 'Ethernet interface name'
  end

  # Properties
  newproperty(:vrf_name) do
    desc 'string 32 characters long'
  end

  newproperty(:bridge_port) do
    desc 'one of yes/no'
  end

  newproperty(:mtu) do
    desc 'integer from 64-9216'

    munge(&:to_i)

    validate do |value|
      unless value.to_i.between?(64, 9216)
        raise 'value not within limit (64-9216)'
      end
    end
  end

  newproperty(:ip_addr) do
    desc 'ip address of interface'
  end

  newproperty(:ip_prefix_len) do
    desc 'integer from 1-32'

    munge(&:to_i)

    validate do |value|
      raise 'value not within limit (1-32)' unless value.to_i.between?(1, 32)
    end
  end

  newproperty(:admin_state) do
    desc 'one of up or down'
  end
end
