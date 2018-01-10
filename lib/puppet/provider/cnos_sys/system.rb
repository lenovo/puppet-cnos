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
