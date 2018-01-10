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

Puppet::Type.newtype(:cnos_vlag_hc) do
  desc ' = {
 	    Manage Vlag Health on Lenovo cnos.

 	    Example:
 	     cnos_vlag_hc {"vlaghealth":
                        "keepalive_interval": 10,
 			"retry_interval": 30,
 			"peer_ip": "10.240.177.120",
 			"vrf": "default",
 			"keepalive_attempts": 3

        	    }
           }'
  ensurable

  # Parameters
  newparam(:title, namevar: true) do
    desc 'name of parameter'
  end

  # Properties
  newproperty(:peer_ip) do
    desc 'ip address'
  end

  newproperty(:vrf) do
    desc 'vrf context string'
  end

  newproperty(:keepalive_attempts) do
    desc 'No of keepalive attempts'

    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(1, 24)
        fail "value not within limit (1-24)"
      end
    end
  end

  newproperty(:keepalive_interval) do
    desc 'No of keepalive interval'

    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(2, 300)
        fail "value not within limit (2-300)"
      end
    end
  end

  newproperty(:retry_interval) do
    desc 'No of keepalive attempts'

    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(1, 300)
        fail "value not within limit (1-300)"
      end
    end
  end
end
