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

Puppet::Type.type(:cnos_vlag_hc).provide(:gem, parent: Puppet::Provider::Cnos) do
  desc 'Manage Vlag_health on Lenovo CNOS. Requires cnos-rbapi'

  mk_resource_methods

  def self.instances
    instances = []
    resp = Puppet::Provider::Cnos.get_vlag_health
    return 'no vlag health' unless resp
    Puppet.debug('Peer Ip is ' + resp['peer_ip'].to_s)
    Puppet.debug('Retry Interval is ' + resp['retry_interval'].to_s)
    Puppet.debug('Keep Alive attempt is ' + resp['keepalive_attempts'].to_s)
    instances << new(name: 'vlag_health',
                     peer_ip: resp['peer_ip'],
                     retry_interval: resp['retry_interval'],
                     keepalive_interval: resp['keepalive_interval'],
                     keepalive_attempts: resp['keepalive_attempts'],
                     ensure: :present,
                     vrf: resp['vrf'])
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
      params['peer_ip'] = resource[:peer_ip] unless resource[:peer_ip].nil?
      params['vrf'] = resource[:vrf] unless resource[:vrf].nil?
      unless resource[:retry_interval].nil?
        params['retry_interval'] = resource[:retry_interval]
      end
      unless resource[:keepalive_interval].nil?
        params['keepalive_interval'] = resource[:keepalive_interval]
      end
      unless resource[:keepalive_attempts].nil?
        params['keepalive_attempts'] = resource[:keepalive_attempts]
      end
      # resp = Vlag.update_vlag_health(conn, params)
      resp = Puppet::Provider::Cnos.update_vlag_health(params)
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
    params = { 'keepalive_interval' => 5, 'keepalive_attempts' => 5, 'retry_interval' => 30 }
    Puppet::Provider::Cnos.update_vlag_health(params)
    @property_hash.clear
  end
end
