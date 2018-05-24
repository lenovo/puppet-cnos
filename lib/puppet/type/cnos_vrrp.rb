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
  desc 'Manage Vrrp on Lenovo CNOS Switches.'
  apply_to_device
  ensurable

  # Parameters
  newparam(:name, namevar: true) do
    desc 'vr_id + interface as String'

    validate do |value|
      super value
      raise('the name must be between 1 and 64 characters long') if value.size > 64
    end
  end

  # Properties
  newproperty(:vr_id, namevar: true) do
    desc 'vr_id an integer from 1-255'

    validate do |value|
      raise 'value not within limit (1-255)' unless value.to_i.between?(1, 255)
    end
  end

  newproperty(:if_name) do
    desc 'Interface name'

    validate do |value|
      super value
      raise('the name must be string representation of interface name') if value.size > 64
    end
  end

  newproperty(:ip_addr) do
    desc 'string 32 characters long'

    validate do |value|
      super value
      raise('the name must be string representation of interface name') if value.size > 11
    end
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

    validate do |value|
      super value
      raise('the name must be string representation of admin_state') if value != 'yes' && value != 'no'
    end
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

    validate do |value|
      super value
      raise('the name must be string representation of admin_state') if value != 'up' && value != 'down'
    end
  end

  newproperty(:track_if) do
    desc 'Interface name'

    validate do |value|
      super value
      raise('the name must be string representation of interface name') if value.size > 64
    end
  end

  newproperty(:accept_mode) do
    desc 'one of yes or no'
    # newvalues('yes', 'no')
    validate do |value|
      super value
      raise('the name must be string representation of admin_state') if value != 'yes' && value != 'no'
    end
  end

  newproperty(:v2_compt) do
    desc 'one of yes, no'

    validate do |value|
      super value
      raise('the name must be string representation of admin_state') if value != 'yes' && value != 'no'
    end
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
