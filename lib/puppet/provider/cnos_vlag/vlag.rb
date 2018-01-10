#
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
require 'cnos-rbapi/vlag'

Puppet::Type.type(:cnos_vlag).provide :vlag do
  desc 'Manage Vlag on Lenovo CNOS. Requires cnos-rbapi'

  confine operatingsystem: [:ubuntu]

  mk_resource_methods

  def self.instances
    provider_val = []
    conn = Connect.new('./config.yml')
    resp = Vlag.get_all_vlag(conn)
    return 'no vlags' if !resp
    resp.each do |item|
      provider_val << new(name: item['inst_id'].to_s,
                          port_aggregator: item['port_aggregator'],
                          ensure: :present,
                          status: item['status'])
    end
    return provider_val
  end

  def self.prefetch(resources)
    vlags = instances
    resources.keys.each do |name|
      if provider = vlags.find { |vlag| vlag.name == name }
        resources[name].provider = provider
      end
    end
  end

  def params_setup
    params = {}
    conn = Connect.new('./config.yml')
    if resource[:status] != nil
      params['status'] = resource[:status]
    end
    if resource[:port_aggregator] != nil
      params['port_aggregator'] = resource[:port_aggregator]
    end
    return params
  end

  def flush
    if @property_hash
      conn = Connect.new('./config.yml')
      params = params_setup
      resp = Vlag.update_vlag_inst(conn, resource[:inst_id], params)
    end
    @property_hash = resource.to_hash
  end

  def create
    conn = Connect.new('./config.yml')
    params = { "inst_id" => resource[:inst_id].to_i,
               "port_aggregator" => resource[:port_aggregator],
               "status" => resource[:status] }
    Vlag.create_vlag_inst(conn, params)
    @property_hash.clear
  end

  def exists?
    @property_hash[:ensure] == :present
  end

  def destroy
    conn = Connect.new('./config.yml')
    Vlag.delete_vlag_inst(conn, resource[:inst_id])
    @property_hash.clear
  end
end
