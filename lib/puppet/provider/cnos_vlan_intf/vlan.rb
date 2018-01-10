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
require 'cnos-rbapi'
require 'cnos-rbapi/vlan_intf'

Puppet::Type.type(:cnos_vlan_intf).provide :vlan do
  desc 'Manage Vlan on Lenovo CNOS. Requires cnos-rbapi'

  confine operatingsystem: [:ubuntu]

  mk_resource_methods

  def self.instances
    conn = Connect.new('./config.yml')
    provider_val = []
    conn = Connect.new('./config.yml')
    resp = VlanIntf.get_all_vlan_intf(conn)
    return 'no vlans' if !resp
    resp.each do |item|
      provider_val << new(:name => item['if_name'],
                          :bridgeport_mode => item['bridgeport_mode'],
                          :ensure => :present,
                          :vlans => item['vlans'],
                          :pvid => item['pvid'])
    end
    return provider_val
 end

  def self.prefetch(resources)
    vlans = instances
    resources.keys.each do |name|
      if provider = vlans.find { |vlan| vlan.name == name }
        resources[name].provider = provider
      end
    end
  end

  def exists?
    @property_hash[:ensure] == :present
    # return true since resource is always present
    return true
  end

  def params_setup
    params = {}
    params['if_name'] = resource[:if_name]
    if resource[:pvid] != nil
      params['pvid'] = resource[:pvid]
    end
    if resource[:vlans] != nil
      params['vlans'] = resource[:vlans]
    end
    if resource[:bridgeport_mode] != nil
      params['bridgeport_mode'] = resource[:bridgeport_mode]
    end
    return params
  end

  def flush
    if @property_hash != {}
      conn = Connect.new('./config.yml')
      params = params_setup
      resp = VlanIntf.update_vlan_intf(conn, resource[:if_name], params)
    end
    @property_hash = resource.to_hash
  end
end
