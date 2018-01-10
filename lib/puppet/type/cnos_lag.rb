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
  ensurable

  # Parameters
  newparam(:lag_id, namevar: true) do
    desc 'lag_id an integer from 1-4096'

    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(1, 4096)
        fail "value not within limit (1-4096)"
      end
    end
  end

  # Properties
  newproperty(:interfaces, array_matching: :all) do
    desc 'array of interfaces dictionary'
=begin
    def insync?(current)
      current.sort == should.sort
    end
=end
  end

  newproperty(:min_links) do
    desc 'lag_id an integer from 1-4096'

    munge do |value|
      value.to_i
    end

    validate do |value|
       unless value.to_i.between?(1, 65535)
         fail "value not within limit (1-65535)"
       end
     end
  end
end
