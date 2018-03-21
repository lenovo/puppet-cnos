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
  apply_to_device
  ensurable

  # Parameters
  newparam(:vr_id, namevar: true) do
    desc 'inst_id an integer from 1-255'

    validate do |value|
      raise 'value not within limit (1-255)' unless value.to_i.between?(1, 255)
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

    munge(&:to_i)

    validate do |value|
      raise 'value not within limit (5-4095)' unless value.to_i.between?(5, 4095)
    end
  end
  newproperty(:preempt) do
    desc 'one of yes or no'
    # newvalues('yes', 'no')
  end

  newproperty(:prio) do
    desc 'prio integer from 1-254'

    munge(&:to_i)

    validate do |value|
      raise 'value not within limit (1-254)' unless value.to_i.between?(1, 254)
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

    munge(&:to_i)

    validate do |value|
      unless value.to_i.between?(1, 500_000)
        raise 'value not within limit (1-254)'
      end
    end
  end
end
