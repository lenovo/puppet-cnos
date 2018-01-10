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

Puppet::Type.newtype(:cnos_vlan_intf) do
  desc ' = {
 	    Manage Vlan_intf on Lenovo cnos.

 	    Example:
 	     cnos_vlan_intf {"<if_name>":
		     bridgeport_mode => access/trunk,
		     pvid => "<pvid>",
		     vlans => ["<vlan_id>"]
              }
           }'

  ensurable

  # Parameters
  newparam(:if_name, namevar: true) do
    desc 'Ethernet interface name'
  end

  # Properties
  newproperty(:bridgeport_mode) do
    newvalues(:access, :trunk)
    desc 'one of access/trunk'
  end

  newproperty(:pvid) do
    desc 'integer from 1-3999'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:vlans, :array_matching => :all) do
    desc 'VLAN memberships'
  end
end
