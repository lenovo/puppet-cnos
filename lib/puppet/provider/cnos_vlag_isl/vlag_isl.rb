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

Puppet::Type.type(:cnos_vlag_isl).provide :vlag_isl do
  desc 'Manage Vlag on Lenovo CNOS. Requires cnos-rbapi'

  confine operatingsystem: [:ubuntu]

  def port_aggregator
    conn = Connect.new('./config.yml')
    resp = Vlag.get_vlag_isl(conn)
    resp['port_aggregator']
  end

  def port_aggregator=(value)
    conn = Connect.new('./config.yml')
    params = { 'port_aggregator' => resource[:port_aggregator] }
    resp = Vlag.update_vlag_isl(conn, params)
  end
end
