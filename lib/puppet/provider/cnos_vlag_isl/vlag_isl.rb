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
