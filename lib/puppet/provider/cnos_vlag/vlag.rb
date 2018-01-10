#
# Copyright (C) 2017 Lenovo, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#       http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
