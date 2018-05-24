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
  desc 'Manage Telemetry feature on Lenovo CNOS Switches.'

  apply_to_device
  ensurable

  # Parameters
  newparam(:bst_feature, namevar: true) do
    desc 'setting bst feature - should be "bst"'
    newvalues('bst', 'bst_feature')
  end

  # Properties
  newproperty(:bst_enable) do
    desc '0/1 for enable or disable'

    munge(&:to_i)

    validate do |value|
      raise 'value either 0 or 1' unless value.to_i != 0 && value.to_i != 1
    end
  end

  newproperty(:send_async_reports) do
    desc '0/1 for enable or disable'

    munge(&:to_i)

    validate do |value|
      raise 'value either 0 or 1' unless value.to_i != 0 && value.to_i != 1
    end
  end

  newproperty(:async_full_report) do
    desc '0/1 for enable or disable'

    munge(&:to_i)

    validate do |value|
      raise 'value either 0 or 1' unless value.to_i != 0 && value.to_i != 1
    end
  end

  newproperty(:collection_interval) do
    desc 'collection interval in seconds'

    munge(&:to_i)
  end

  newproperty(:trigger_rate_limit) do
    desc 'trigger rate limit'

    munge(&:to_i)

    validate do |value|
      raise 'value not within limit (1-5)' unless value.to_i.between?(1, 5)
    end
  end

  newproperty(:trigger_rate_limit_interval) do
    desc '0/1 for enable or disable'

    munge(&:to_i)

    validate do |value|
      raise 'value not within limit (10-60)' unless value.to_i.between?(10, 60)
    end
  end

  newproperty(:send_snapshot_on_trigger) do
    desc '0/1 for enable or disable'

    munge(&:to_i)

    validate do |value|
      raise 'value either 0 or 1' unless value.to_i != 0 && value.to_i != 1
    end
  end

  newproperty(:async_full_reports) do
    desc '0/1 for enable or disable'

    munge(&:to_i)

    validate do |value|
      raise 'value either 0 or 1' unless value.to_i != 0 && value.to_i != 1
    end
  end
end
