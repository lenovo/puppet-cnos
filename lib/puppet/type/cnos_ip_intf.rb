#
# Copyright (C) 2017 Lenovo, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#       http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
  ensurable

  # Parameters
  newparam(:if_name, namevar: true) do
    desc 'Ethernet interface name'
  end

  newparam(:vrf_name) do
    desc 'string 32 characters long'
  end

  # Properties
  newproperty(:bridge_port) do
    desc 'one of yes/no'
  end

  newproperty(:mtu) do
    desc 'integer from 64-9216'

    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(64, 9216)
        fail "value not within limit (64-9216)"
      end
    end
  end

  newproperty(:ip_addr) do
    desc 'ip address of interface'
  end

  newproperty(:ip_prefix_len) do
    desc 'integer from 1-32'

    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(1, 32)
        fail "value not within limit (1-32)"
      end
    end
  end

  newproperty(:admin_state) do
    desc 'one of up or down'
  end
end
