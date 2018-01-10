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

Puppet::Type.type(:cnos_vlag_hc).provide :vlag_health do
  desc 'Manage Vlag_health on Lenovo CNOS. Requires cnos-rbapi'

  confine operatingsystem: [:ubuntu]
  mk_resource_methods

  def self.instances
    provider_val = []
    conn = Connect.new('./config.yml')
    resp = Vlag.get_vlag_health(conn)
    return 'no vlag health' if !resp
    provider_val << new(name: 'vlag_health',
                          peer_ip: resp['peer_ip'],
                          retry_interval: resp['retry_interval'],
                          keepalive_interval: resp['keepalive_interval'],
                          keepalive_attempts: resp['keepalive_attempts'],
                          ensure: :present,
                          vrf: resp['vrf'])
    return provider_val
  end

  def self.prefetch(resources)
    vlag = instances
    resources.keys.each do |name|
      if provider = vlag.find { |vlag| TRUE }
        resources[name].provider = provider
      end
    end
  end
 
  def flush
    params = {}
    if @property_hash != {}
      puts @property_hash
      conn = Connect.new('./config.yml')
      if resource[:peer_ip] != nil
        params['peer_ip'] = resource[:peer_ip]
      end
      if resource[:vrf] != nil
        params['vrf'] = resource[:vrf]
      end
      if resource[:retry_interval] != nil
        params['retry_interval'] = resource[:retry_interval]
      end
      if resource[:keepalive_interval] != nil
        params['keepalive_interval'] = resource[:keepalive_interval]
      end
      if resource[:keepalive_attempts] != nil
        params['keepalive_attempts'] = resource[:keepalive_attempts]
      end
      resp = Vlag.update_vlag_health(conn, params)
    end
    @property_hash = resource.to_hash
  end
 
  def exists?
    @property_hash[:ensure] == :present
    return true
  end
  
  def destroy
    # restoring to default values since there is no delete
    conn = Connect.new('./config.yml')
    params = {"keepalive_interval" => 5, "keepalive_attempts" => 5, "retry_interval" => 30}
    Vlag.update_vlag_health(conn, params)
    @property_hash.clear
  end
end
