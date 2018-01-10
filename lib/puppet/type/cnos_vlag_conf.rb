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
