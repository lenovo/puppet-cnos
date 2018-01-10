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
require 'cnos-rbapi/telemetry'

Puppet::Type.type(:cnos_sys).provide :system do
  desc 'Manage System properties on Lenovo CNOS. Requires cnos-rbapi'

  confine operatingsystem: [:ubuntu]

  def heartbeat_enable
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_sys_feature(conn)
    resp['heartbeat-enable']
  end

  def msg_interval
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_sys_feature(conn)
    resp['msg-interval']
  end

  def heartbeat_enable=(value)
    conn = Connect.new('./config.yml')
    params = { 'heartbeat-enable' => resource[:heartbeat_enable],
               'msg-interval' => resource[:msg_interval] }
    resp = Telemetry.set_sys_feature(conn, params)
  end

  def msg_interval=(value)
    conn = Connect.new('./config.yml')
    params = { 'heartbeat-enable' => resource[:heartbeat_enable],
               'msg-interval' => resource[:msg_interval] }
    resp = Telemetry.set_sys_feature(conn, params)
  end
end
