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

Puppet::Type.type(:cnos_vlag_isl).provide(:gem, parent: Puppet::Provider::Cnos) do
  desc 'Manage Vlag on Lenovo CNOS. Requires cnos-rbapi'

  mk_resource_methods

  def self.instances
    resp = Puppet::Provider::Cnos.fetch_vlag_isl
    return [] if resp.nil?
    resp['port_aggregator']
  end

  def exists?
    Puppet.debug('I am inside exists')
    @property_hash[:ensure] == :present
    # return true since resource is always present
    true
  end

  def flush
    Puppet.debug('I am inside flush')
    # params = {}
    if @property_hash != {}
      params = { 'port_aggregator' => resource[:port_aggregator] }
      Puppet::Provider::Cnos.update_vlag_isl(params)
    end
    @property_hash = resource.to_hash
  end

  def destroy
    Puppet.debug('I am inside destroy')
    # This is not supported as of now
    @property_hash.clear
  end
end
