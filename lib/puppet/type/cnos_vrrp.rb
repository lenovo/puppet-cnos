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

Puppet::Type.newtype(:cnos_vrrp) do
  desc ' = {
 	    Manage Vrrp on Lenovo cnos.

 	    Example:
 	     cnos_vrrp {if_name:
			    "vr_id": "<vr_id>",
			    "ip_addr": "<ip_addr>",
			    "ad_intvl": "<ad_intvl>",
			    "preempt": "<preempt>",
			    "prio": "<prio>",
			    "admin_state": "<admin_state>",
			    "track_if": "<track_if>",
			    "accept_mode": "<accept_mode>",
			    "switch_back_delay": "<switch_back_delay>",
			    "v2_compt": "<v2_compt>"
        	       }
            }'
  ensurable

  # Parameters
  newparam(:vr_id, namevar: true) do
    desc 'inst_id an integer from 1-255'

    validate do |value|
      unless value.to_i.between?(1, 255)
        fail "value not within limit (1-255)"
      end
    end
  end

  newparam(:if_name) do
    desc 'Interface name'
  end
  # Properties
  newproperty(:ip_addr) do
    desc 'string 32 characters long'
  end

  newproperty(:ad_intvl) do
    desc 'inst_id an integer from 5-4095'

    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(5, 4095)
        fail "value not within limit (5-4095)"
      end
    end
  end
  newproperty(:preempt) do
    desc 'one of yes or no'
    # newvalues('yes', 'no')
  end

  newproperty(:prio) do
    desc 'prio integer from 1-254'

    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(1, 254)
        fail "value not within limit (1-254)"
      end
    end
  end

  newproperty(:admin_state) do
    desc 'one of up or down'
    # newvalues('up', 'down')
  end

  newproperty(:track_if) do
    desc 'Interface name'
  end

  newproperty(:accept_mode) do
    desc 'one of yes or no'
    newvalues('yes', 'no')
  end

  newproperty(:v2_compt) do
    desc 'one of yes, no'
    # newvalues('yes', 'no')
  end

  newproperty(:switch_back_delay) do
    desc 'prio integer from 1-500000'

    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(1, 500000)
        fail "value not within limit (1-254)"
      end
    end
  end
end
