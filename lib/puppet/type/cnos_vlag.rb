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
