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

Puppet::Type.type(:cnos_telemetry).provide :bst_feature do
  desc 'Manage BST feature on Lenovo CNOS. Requires cnos-rbapi'
  
  mk_resource_methods
  confine operatingsystem: [:ubuntu]

  def self.instances
    provider_val = []
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_feature(conn)
    return 'no bst feature' if !resp
    provider_val << new(name: 'telemetry_feature',
                          bst_enable: resp['bst_enable'],
                          send_async_reports: resp['send_async_reports'],
                          collection_interval: resp['collection_interval'],
                          trigger_rate_limit: resp['trigger_rate_limit'],
                          ensure: :present,
                          trigger_rate_limit_interval: resp['trigger_rate_limit_interval'],
                          send_snapshot_on_trigger: resp['send-snapshot-on-trigger'])
    
    puts "1 " 
    puts  @property_hash
    return provider_val
  end

  def self.prefetch(resources)
    feature = instances
    resources.keys.each do |name|
      if provider = feature.find { |feature| TRUE }
        resources[name].provider = provider
      end
    end
  end

  def params_setup
    params = {}
    params =
      {
        "collection-interval" => resource[:collection_interval],
        "send-async-reports" => resource[:send_async_reports],
        "send-snapshot-on-trigger" => resource[:send_snapshot_on_trigger],
        "trigger-rate-limit" => resource[:trigger_rate_limit],
        "async-full-report" => resource[:async_full_report],
        "trigger-rate-limit-interval" => resource[:trigger_rate_limit_interval],
        "bst-enable" => resource[:bst_enable]
      }
    return params
  end

  def exists?
    @property_hash[:ensure] == :present
    return true
  end

  def flush
    puts  @property_hash
    if @property_hash
      puts "hello"
      conn = Connect.new('./config.yml')
      params = params_setup
      Telemetry.set_bst_feature(conn, params)
    end
    @property_hash = resource.to_hash
  end

end
