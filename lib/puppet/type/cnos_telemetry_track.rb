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

Puppet::Type.newtype(:cnos_telemetry_track) do
  desc 'Manage Telemetry tracking on Lenovo CNOS Switches.'

  apply_to_device
  ensurable

  # Parameters
  newparam(:bst_track, namevar: true) do
    desc 'setting bst tracking - should be "bst"'
    newvalues('bst', 'bst_track')
  end

  # Properties
  newproperty(:track_peak_stats) do
    desc '0/1 for enable or disable'

    munge(&:to_i)

    validate do |value|
      raise 'value either 0 or 1' unless value.to_i != 0 && value.to_i != 1
    end
  end

  newproperty(:track_ingress_port_priority_group) do
    desc '0/1 for enable or disable'

    munge(&:to_i)

    validate do |value|
      raise 'value either 0 or 1' unless value.to_i != 0 && value.to_i != 1
    end
  end

  newproperty(:track_ingress_port_service_pool) do
    desc '0/1 for enable or disable'

    munge(&:to_i)

    validate do |value|
      raise 'value either 0 or 1' unless value.to_i != 0 && value.to_i != 1
    end
  end

  newproperty(:track_ingress_service_pool) do
    desc '0/1 for enable or disable'

    munge(&:to_i)

    validate do |value|
      raise 'value either 0 or 1' unless value.to_i != 0 && value.to_i != 1
    end
  end

  newproperty(:track_egress_port_service_pool) do
    desc '0/1 for enable or disable'

    munge(&:to_i)

    validate do |value|
      raise 'value either 0 or 1' unless value.to_i != 0 && value.to_i != 1
    end
  end

  newproperty(:track_egress_service_pool) do
    desc '0/1 for enable or disable'

    munge(&:to_i)

    validate do |value|
      raise 'value either 0 or 1' unless value.to_i != 0 && value.to_i != 1
    end
  end

  newproperty(:track_egress_uc_queue) do
    desc '0/1 for enable or disable'

    munge(&:to_i)

    validate do |value|
      raise 'value either 0 or 1' unless value.to_i != 0 && value.to_i != 1
    end
  end

  newproperty(:track_egress_rqe_queue) do
    desc '0/1 for enable or disable'

    munge(&:to_i)

    validate do |value|
      raise 'value either 0 or 1' unless value.to_i != 0 && value.to_i != 1
    end
  end

  newproperty(:track_egress_cpu_queue) do
    desc '0/1 for enable or disable'

    munge(&:to_i)

    validate do |value|
      raise 'value either 0 or 1' unless value.to_i != 0 && value.to_i != 1
    end
  end

  newproperty(:track_egress_mc_queue) do
    desc '0/1 for enable or disable'

    munge(&:to_i)

    validate do |value|
      raise 'value either 0 or 1' unless value.to_i != 0 && value.to_i != 1
    end
  end

  newproperty(:track_device) do
    desc '0/1 for enable or disable'

    munge(&:to_i)

    validate do |value|
      raise 'value either 0 or 1' unless value.to_i != 0 && value.to_i != 1
    end
  end
end
