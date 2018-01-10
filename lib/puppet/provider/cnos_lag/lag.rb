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
require 'cnos-rbapi/lag'

Puppet::Type.type(:cnos_lag).provide :lag do
  desc 'Manage lag on Lenovo CNOS. Requires cnos-rbapi'

  confine operatingsystem: [:ubuntu]

  def params_setup
    params = {}
    conn = Connect.new('./config.yml')
    params['lag_id'] = resource[:lag_id]
    if resource[:min_links] != nil
      params['min_links'] = resource[:min_links]
    end
    if resource[:interfaces] != nil
      params['interfaces'] = resource[:interfaces]
    end
    return params
  end

  def interfaces
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Lag.get_lag_prop(conn, resource[:lag_id])
    resp['interfaces']
  end

  def min_links
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Lag.get_lag_prop(conn, resource[:lag_id])
    resp['min_links']
  end
 
  def min_links=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Lag.update_lag(conn, resource[:lag_id], params)
  end
  
  def interfaces=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Lag.update_lag(conn, resource[:lag_id], params)
  end
 
  def create
    conn = Connect.new('./config.yml')
    Lag.create_lag(conn, resource[:lag_id], resource[:interfaces])
  end

  def exists?
    conn = Connect.new('./config.yml')
    resp = Lag.get_lag_prop(conn, resource[:lag_id])
    resp != nil
  end

  def destroy
    conn = Connect.new('./config.yml')
    Lag.delete_lag(conn, resource[:lag_id])
  end
end
