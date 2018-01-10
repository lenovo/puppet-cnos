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

Puppet::Type.newtype(:cnos_telemetry_track) do
  desc ' = {
 	    Manage Telemetry tracking on Lenovo cnos.

 	    Example:
 	     cnos_telemetry_track {"bst":
			    "track-egress-port-service-pool": 1,
			    "track-egress-uc-queue": 1,
			    "track-egress-rqe-queue": 1,
			    "track-egress-cpu-queue": 1,
			    "track-ingress-port-service-pool": 1,
			    "track-ingress-service-pool": 1,
			    "track-egress-mc-queue": 1,
			    "track-peak-stats": 0,
			    "track-ingress-port-priority-group": 1,
			    "track-egress-service-pool": 1,
			    "track-device": 1
        	    }
           }'

  # Parameters
  newparam(:bst_track, namevar: true) do
    desc 'setting bst tracking - should be "bst"'
    newvalues("bst", "bst_track")
  end

  # Properties
  newproperty(:track_peak_stats) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:track_ingress_port_priority_group) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:track_ingress_port_service_pool) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:track_ingress_service_pool) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:track_egress_port_service_pool) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:track_egress_service_pool) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:track_egress_uc_queue) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:track_egress_rqe_queue) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:track_egress_cpu_queue) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:track_egress_mc_queue) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:track_device) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end
end
