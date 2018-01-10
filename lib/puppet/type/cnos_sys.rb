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

Puppet::Type.newtype(:cnos_sys) do
  desc ' = {
 	    Manage Telemetry system properties on Lenovo cnos.

 	    Example:
 	     cnos_sys{"sys":
		       heartbeat_enable => 1,
		       msg_interval => 10,
                     }
           }'

  # Parameters
  newparam(:sys_feature, namevar: true) do
    desc 'setting system feature - should be "sys"'
    newvalues("sys", "system")
  end

  # Properties
  newproperty(:heartbeat_enable) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:msg_interval) do
    desc 'determines interval of heartbeat message'

    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(1, 600)
        fail "value not within limit (1-600)"
      end
    end
  end
end
