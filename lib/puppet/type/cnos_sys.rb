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

Puppet::Type.newtype(:cnos_sys) do
  desc ' = {
            Manage Telemetry system properties on Lenovo cnos.
            Example:
              cnos_sys{"sys":
                heartbeat_enable => 1,
                msg_interval => 10,
              }
           }'

  apply_to_device
  ensurable
	
  # Parameters
  newparam(:sys_feature, namevar: true) do
    desc 'setting system feature - should be "sys"'
    newvalues('sys', 'system')
  end

  # Properties
  newproperty(:heartbeat_enable) do
    desc '0/1 for enable or disable'

    munge(&:to_i)
  end

  newproperty(:msg_interval) do
    desc 'determines interval of heartbeat message'

    munge(&:to_i)

    validate do |value|
      raise 'value not within limit (1-600)' unless value.to_i.between?(1, 600)
    end
  end
end
