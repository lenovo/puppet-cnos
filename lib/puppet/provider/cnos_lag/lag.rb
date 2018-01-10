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
