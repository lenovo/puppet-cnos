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

Puppet::Type.type(:cnos_vlag_conf).provide(:gem, parent: Puppet::Provider::Cnos) do
  desc 'Manage Vlag_conf on Lenovo CNOS. Requires cnos-rbapi'

  mk_resource_methods

  def self.instances
    instances = []
    resp = Puppet::Provider::Cnos.get_vlag_conf
    return 'no vlag conf' unless resp
    Puppet.debug('Vlag Status is ' + resp['status'].to_s)
    Puppet.debug('Vlan priority is ' + resp['priority'].to_s)
    Puppet.debug('Start Up Delay is ' + resp['startup_delay'].to_s)
    instances << new(name: 'vlag_health',
                     status: resp['status'],
                     priority: resp['priority'],
                     auto_recover: resp['auto_recover'],
                     startup_delay: resp['startup_delay'],
                     ensure: :present,
                     tier_id: resp['tier_id'])
    instances
  end

  def self.prefetch(resources)
    Puppet.debug('I am inside prefetch')
    vlag = instances
    resources.keys.each do |name|
      if provider = vlag.find { |_vlag| true }
        Puppet.debug("Prefetch data coming here is #{provider}")
        resources[name].provider = provider
      end
    end
  end

  def flush
    Puppet.debug('I am inside flush')
    params = {}
    if @property_hash != {}
      puts @property_hash
      params['status'] = resource[:status] unless resource[:status].nil?
      params['tier_id'] = resource[:tier_id] unless resource[:tier_id].nil?
      params['priority'] = resource[:priority] unless resource[:priority].nil?
      unless resource[:auto_recover].nil?
        params['auto_recover'] = resource[:auto_recover]
      end
      unless resource[:startup_delay].nil?
        params['startup_delay'] = resource[:startup_delay]
      end
      resp = Puppet::Provider::Cnos.update_vlag_conf(params)
    end
    @property_hash = resource.to_hash
  end

  def exists?
    Puppet.debug('I am inside exists')
    @property_hash[:ensure] == :present
    true
  end

  def destroy
    Puppet.debug('I am inside destroy')
    @property_hash.clear
  end
end
