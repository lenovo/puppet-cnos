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

Puppet::Type.type(:cnos_sys).provide(:gem, parent: Puppet::Provider::Cnos) do
  desc 'Manage System properties on Lenovo CNOS. Requires cnos-rbapi'

  mk_resource_methods

  def heartbeat_enable
    resp = Puppet::Provider::Cnos.get_sys_feature
    resp['heartbeat-enable']
  end

  def msg_interval
    resp = Puppet::Provider::Cnos.get_sys_feature
    resp['msg-interval']
  end

  def heartbeat_enable=(_value)
    params = { 'heartbeat-enable' => resource[:heartbeat_enable],
               'msg-interval' => resource[:msg_interval] }
    resp = Puppet::Provider::Cnos.set_sys_feature(params)
  end

  def msg_interval=(_value)
    params = { 'heartbeat-enable' => resource[:heartbeat_enable],
               'msg-interval' => resource[:msg_interval] }
    resp = Puppet::Provider::Cnos.set_sys_feature(params)
  end

  def exists?
    resp = Puppet::Provider::Cnos.get_sys_feature
    resp != nil
  end

end
