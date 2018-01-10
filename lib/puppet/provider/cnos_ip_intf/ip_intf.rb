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
require 'cnos-rbapi/ip_intf'

Puppet::Type.type(:cnos_ip_intf).provide :ip_intf do
  desc 'Manage IP interfaces on Lenovo CNOS. Requires cnos-rbapi'

  confine operatingsystem: [:ubuntu]

  mk_resource_methods

  def self.instances
    provider_val = []
    conn = Connect.new('./config.yml')
    resp = Ipintf.get_ip_prop_all(conn)
    return 'no ip_intf' if !resp
    resp.each do |item|
      provider_val << new(name: item['if_name'],
                          vrf_name: item['vrf_name'],
                          bridge_port: item['bridge_port'],
                          mtu: item['mtu'],
                          ip_addr: item['ip_addr'],
                          ip_prefix_len: item[:ip_prefix_len],
                          admin_state: item[:admin_state],
                          ensure: :present,)
    end
    return provider_val
  end

  def self.prefetch(resources)
    ip_intfs = instances
    resources.keys.each do |name|
      if provider = ip_intfs.find { |ip_intf| ip_intf.name == name }
        resources[name].provider = provider
      end
    end
  end

  def flush
    if @property_hash
      conn = Connect.new('./config.yml')
      params = params_setup
      resp = Ipintf.update_ip_prop_intf(conn, resource[:if_name], params)
    end
    @property_hash = resource.to_hash
  end

  def params_setup
    params = {}
    params['if_name'] = resource[:if_name]
    if resource[:bridge_port] != nil
      params['bridge_port'] = resource[:bridge_port]
    end
    if resource[:mtu] != nil
      params['mtu'] = resource[:mtu]
    end
    if resource[:ip_addr] != nil
      params['ip_addr'] = resource[:ip_addr]
    end
    if resource[:ip_prefix_len] != nil
      params['ip_prefix_len'] = resource[:ip_prefix_len]
    end
    if resource[:vrf_name] != nil
      params['vrf_name'] = resource[:vrf_name]
    end
    if resource[:admin_state] != nil
      params['admin_state'] = resource[:admin_state]
    end
    return params
  end

  def exists?
    @property_hash[:ensure] == :present
  end
end
