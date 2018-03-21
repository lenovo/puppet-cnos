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

  apply_to_device
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

    munge(&:to_i)

    validate do |value|
      raise 'value not within limit (1-24)' unless value.to_i.between?(1, 24)
    end
  end

  newproperty(:keepalive_interval) do
    desc 'No of keepalive interval'

    munge(&:to_i)

    validate do |value|
      raise 'value not within limit (2-300)' unless value.to_i.between?(2, 300)
    end
  end

  newproperty(:retry_interval) do
    desc 'No of keepalive attempts'

    munge(&:to_i)

    validate do |value|
      raise 'value not within limit (1-300)' unless value.to_i.between?(1, 300)
    end
  end
end
