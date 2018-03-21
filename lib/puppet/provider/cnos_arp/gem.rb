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

require 'puppet/type'
require File.join(File.dirname(__FILE__), '../cnos')
require 'json'

Puppet::Type.type(:cnos_arp).provide(:gem, parent: Puppet::Provider::Cnos) do
  desc 'Manage Arp on Lenovo CNOS. Requires cnos-rbapi'

  mk_resource_methods

  def self.instances
    resp = Puppet::Provider::Cnos.get_arp_intf_prop(resource[:if_name])
    return [] if resp.nil?
    resp['ageout_time']
  end

  def exists?
    Puppet.debug('I am inside exists')
    @property_hash[:ensure] == :present
    # return true since resource is always present
    true
  end

  def flush
    Puppet.debug('I am inside flush')
    params = {}
    if @property_hash != {}
      params = { 'if_name' => resource[:if_name], 'ageout_time' => resource[:ageout_time] }
      resp = Puppet::Provider::Cnos.set_arp_intf_prop(resource[:if_name], params)
    end
    @property_hash = resource.to_hash
  end

  def create
    Puppet.debug('I am inside create')
    params = { 'if_name' => resource[:if_name], 'ageout_time' => resource[:ageout_time] }
    resp = Puppet::Provider::Cnos.set_arp_intf_prop(resource[:if_name], params)
    @property_hash.clear
  end
end
