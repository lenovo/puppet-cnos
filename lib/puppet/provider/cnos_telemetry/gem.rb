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

Puppet::Type.type(:cnos_telemetry).provide(:gem, parent: Puppet::Provider::Cnos) do
  desc 'Manage BST feature on Lenovo CNOS. Requires cnos-rbapi'

  mk_resource_methods

  def self.instances
    instances = []
    resp = Puppet::Provider::Cnos.get_bst_feature
    return 'no bst feature' unless resp
    Puppet.debug('BST Enable is ' + resp['bst_enable'].to_s)
    Puppet.debug('Collection Intervael is ' + resp['collection_interval'].to_s)
    Puppet.debug('Trigger Rate Limit is ' + resp['trigger_rate_limit'].to_s)
    instances << new(name: 'telemetry_feature',
                     bst_enable: resp['bst_enable'],
                     send_async_reports: resp['send_async_reports'],
                     collection_interval: resp['collection_interval'],
                     trigger_rate_limit: resp['trigger_rate_limit'],
                     ensure: :present,
                     trigger_rate_limit_interval: resp['trigger_rate_limit_interval'],
                     send_snapshot_on_trigger: resp['send-snapshot-on-trigger'])

    puts '1 '
    puts @property_hash
    instances
  end

  def self.prefetch(resources)
    Puppet.debug('I am inside prefetch')
    feature = instances
    resources.keys.each do |name|
      if provider = feature.find { |_feature| TRUE }
        Puppet.debug("Prefetch data coming here is #{provider}")
        resources[name].provider = provider
      end
    end
  end

  def params_setup
    params = {}
    params =
      {
        'collection-interval'         => resource[:collection_interval],
        'send-async-reports'          => resource[:send_async_reports],
        'send-snapshot-on-trigger'    => resource[:send_snapshot_on_trigger],
        'trigger-rate-limit'          => resource[:trigger_rate_limit],
        'async-full-report'           => resource[:async_full_report],
        'trigger-rate-limit-interval' => resource[:trigger_rate_limit_interval],
        'bst-enable'                  => resource[:bst_enable]
      }
    params
  end

  def exists?
    Puppet.debug('I am inside exists')
    @property_hash[:ensure] == :present
    true
  end

  def flush
    Puppet.debug('I am inside flush')
    puts @property_hash
    if @property_hash
      puts 'hello'
      params = params_setup
      Puppet::Provider::Cnos.set_bst_feature(params)
    end
    @property_hash = resource.to_hash
  end
end
