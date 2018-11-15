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

Puppet::Type.type(:cnos_vlan_intf).provide(:gem, parent: Puppet::Provider::Cnos) do
  desc 'Manage Vlan on Lenovo CNOS. Requires cnos-rbapi'

  mk_resource_methods

  def self.instances
    Puppet.debug('I am inside instances')
    instances = []
    resp = Puppet::Provider::Cnos.fetch_all_vlan_intf
    return 'no vlans' unless resp
    resp.each do |item|
      Puppet.debug('Interface Name is ' + item['if_name'].to_s)
      Puppet.debug('bridgeport_mode is ' + item['bridgeport_mode'].to_s)
      Puppet.debug('PVID is ' + item['pvid'].to_s)
      instances << new(name:  item['if_name'],
                       bridgeport_mode: item['bridgeport_mode'],
                       if_name: item['if_name'],
                       ensure: :present,
                       vlans: item['vlans'],
                       pvid:  item['pvid'])
    end
    instances
  end

  def self.prefetch(resources)
    Puppet.debug('I am inside prefetch')
    vlans = instances
    resources.keys.each do |name|
      if (provider = vlans.find { |vlan| vlan.name == name })
        Puppet.debug("Prefetch data coming here is #{provider}")
        resources[name].provider = provider
      end
    end
  end

  def exists?
    Puppet.debug('I am inside exists')
    @property_hash[:ensure].should eq(:present)
    # return true since resource is always present
    true
  end

  def params_setup
    params = {}
    params['if_name'] = resource[:if_name]
    params['pvid'] = resource[:pvid] unless resource[:pvid].nil?
    params['vlans'] = resource[:vlans] unless resource[:vlans].nil?
    unless resource[:bridgeport_mode].nil?
      params['bridgeport_mode'] = resource[:bridgeport_mode]
    end
    params
  end

  def flush
    Puppet.debug('I am inside flush')
    if @property_hash != {}
      params = params_setup
      Puppet::Provider::Cnos.update_vlan_intf(resource[:if_name], params)
    end
    @property_hash = resource.to_hash
  end

  def destroy
    Puppet.debug('I am inside destroy')
    params = {}
    params['if_name'] = resource[:if_name]
    params['pvid'] = resource[:pvid] unless resource[:pvid].nil?
    params['vlans'] = 'none'
    unless resource[:bridgeport_mode].nil?
      params['bridgeport_mode'] = resource[:bridgeport_mode]
    end
    Puppet::Provider::Cnos.update_vlan_intf(resource[:if_name], params)
    @property_hash.clear
  end
end
