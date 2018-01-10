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

Puppet::Type.newtype(:cnos_vlan) do
  desc ' = {
 	    Manage Vlans on Lenovo cnos.

 	    Example:
 	     cnos_vlan {1:
		     vlan_name => vlan1,
		     admin_state => up,
              }
           }'
  ensurable

  # Parameters
  newparam(:vlan_id, namevar: true) do
    desc 'vlan_id an integer from 2-3999'

=begin    munge do |value|
      value.to_i
    end
=end
    validate do |value|
      unless value.to_i.between?(1, 3999)
        fail "value not within limit (2-3999)"
      end
    end
  end

  # Properties
  newproperty(:vlan_name) do
    desc 'string 32 characters long'
  end

  newproperty(:admin_state) do
    desc 'one of up or down'
  end
end
