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
require File.join(File.dirname(__FILE__), '../cnos')
require 'json'

Puppet::Type.type(:cnos_lag).provide(:gem, parent: Puppet::Provider::Cnos) do
  desc 'Manage lag on Lenovo CNOS. Requires cnos-rbapi'

  mk_resource_methods

  def params_setup
    params = {}
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
    params = params_setup
    resp = Puppet::Provider::Cnos.get_lag_prop(resource[:lag_id])
    resp['interfaces']
  end

  def min_links
    params = params_setup
    resp = Puppet::Provider::Cnos.get_lag_prop(resource[:lag_id])
    resp['min_links']
  end

  def min_links=(value)
    params = params_setup
    resp = Puppet::Provider::Cnos.get_lag_prop(resource[:lag_id])
  end

  def interfaces=(value)
    params = params_setup
    resp = Puppet::Provider::Cnos.update_lag(resource[:lag_id], params)
  end

  def create
    Puppet::Provider::Cnos.create_lag(resource[:lag_id], resource[:interfaces])
  end

  def exists?
    resp = Puppet::Provider::Cnos.get_lag_prop(resource[:lag_id])
    resp != nil
  end

  def destroy
    Puppet::Provider::Cnos.delete_lag(resource[:lag_id])
  end
end
