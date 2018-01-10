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
require 'cnos-rbapi/vlan'

Puppet::Type.type(:cnos_vlan).provide :vlan do
  desc 'Manage Vlan on Lenovo CNOS. Requires cnos-rbapi'

  confine operatingsystem: [:ubuntu]

  mk_resource_methods
  conn = Connect.new('./config.yml')

  def self.instances
    provider_val = []
    conn = Connect.new('./config.yml')
    resp = Vlan.get_all_vlan(conn)
    return 'no vlans' if !resp
    resp.each do |item|
      provider_val << new(name: item['vlan_id'].to_s,
                          vlan_name: item['vlan_name'],
                          ensure: :present,
                          admin_state: item['admin_state'])
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

  def flush
    params = {}
    if @property_hash != {}
      conn = Connect.new('./config.yml')
      if resource[:vlan_name] != nil
        params['vlan_name'] = resource[:vlan_name]
      end
      if resource[:admin_state] != nil
        params['admin_state'] = resource[:admin_state]
      end
      resp = Vlan.update_vlan(conn, resource[:vlan_id], params)
    end
    @property_hash = resource.to_hash
  end

  def create
    conn = Connect.new('./config.yml')
    params = { "vlan_id" => resource[:vlan_id].to_i,
               "vlan_name" => resource[:vlan_name],
               "admin_state" => resource[:admin_state] }
    Vlan.create_vlan(conn, params)
    @property_hash.clear
  end

  def exists?
    @property_hash[:ensure] == :present
  end

  def destroy
    Vlan.delete_vlan(conn, resource[:vlan_id])
    @property_hash.clear
  end
end
