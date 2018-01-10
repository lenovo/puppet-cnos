# Copyright (c) 2017, Lenovo. All rights reserved.
#
# This program and the accompanying materials are licensed and made available
# under the terms and conditions of the 3-clause BSD License that accompanies 
# this distribution. The full text of the license may be found at
#
# https://opensource.org/licenses/BSD-3-Clause
#
# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, WITHOUT
# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.

Puppet::Type.newtype(:cnos_telemetry) do
  desc ' = {
 	    Manage Telemetry feature on Lenovo cnos.

 	    Example:
 	     cnos_telemetry {"bst":
			 "bst­enable": 1,
			 "send­async­reports": 1,
			 "collection­interval": 300,
			 "trigger­rate­limit": 5,
			 "trigger­rate­limit­interval": 2,
			 "send­snapshot­on­trigger": 1,
			 "async­full­reports": 1,
        	}
           }'
  ensurable

  # Parameters
  newparam(:bst_feature, namevar: true) do
    desc 'setting bst feature - should be "bst"'
    newvalues("bst", "bst_feature")
  end

  # Properties
  newproperty(:bst_enable) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:send_async_reports) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:async_full_report) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:collection_interval) do
    desc 'collection interval in seconds'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:trigger_rate_limit) do
    desc 'trigger rate limit'

    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(1, 5)
        fail "value not within limit (1-5)"
      end
    end
  end

  newproperty(:trigger_rate_limit_interval) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end

    validate do |value|
      unless value.to_i.between?(10, 60)
        fail "value not within limit (10-60)"
      end
    end
  end

  newproperty(:send_snapshot_on_trigger) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end

  newproperty(:async_full_reports) do
    desc '0/1 for enable or disable'

    munge do |value|
      value.to_i
    end
  end
end
