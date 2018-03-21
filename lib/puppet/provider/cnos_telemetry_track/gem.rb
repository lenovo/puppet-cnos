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

Puppet::Type.type(:cnos_telemetry_track).provide(:gem, parent: Puppet::Provider::Cnos) do
  desc 'Manage BST Tracking on Lenovo CNOS. Requires cnos-rbapi'

  # confine operatingsystem: [:ubuntu]
  mk_resource_methods

  def track_device
    resp = Puppet::Provider::Cnos.get_bst_tracking
    resp['track-device']
  end

  def track_egress_port_service_pool
    resp = Puppet::Provider::Cnos.get_bst_tracking
    resp['track-egress-port-service-pool']
  end

  def track_egress_uc_queue
    resp = Puppet::Provider::Cnos.get_bst_tracking
    resp['track-egress-uc-queue']
  end

  def track_egress_rqe_queue
    resp = Puppet::Provider::Cnos.get_bst_tracking
    resp['track-egress-rqe-queue']
  end

  def track_egress_cpu_queue
    resp = Puppet::Provider::Cnos.get_bst_tracking
    resp['track-egress-cpu-queue']
  end

  def track_egress_mc_queue
    resp = Puppet::Provider::Cnos.get_bst_tracking
    resp['track-egress-mc-queue']
  end

  def track_egress_service_pool
    resp = Puppet::Provider::Cnos.get_bst_tracking
    resp['track-egress-service-pool']
  end

  def track_ingress_service_pool
    resp = Puppet::Provider::Cnos.get_bst_tracking
    resp['track-ingress-service-pool']
  end

  def track_ingress_port_service_pool
    resp = Puppet::Provider::Cnos.get_bst_tracking
    resp['track-ingress-port-service-pool']
  end

  def track_ingress_port_priority_group
    resp = Puppet::Provider::Cnos.get_bst_tracking
    resp['track-ingress-port-priority-group']
  end

  def track_peak_stats
    resp = Puppet::Provider::Cnos.get_bst_tracking
    puts 'here'
    resp['track-peak-stats']
  end

  def params_setup
    params =
      {
        'track-egress-port-service-pool'    => resource[:track_egress_port_service_pool],
        'track-egress-uc-queue'             => resource[:track_egress_uc_queue],
        'track-egress-rqe-queue'            => resource[:track_egress_cpu_queue],
        'track-egress-cpu-queue'            => resource[:track_egress_cpu_queue],
        'track-ingress-port-service-pool'   => resource[:track_ingress_port_service_pool],
        'track-ingress-service-pool'        => resource[:track_ingress_service_pool],
        'track-egress-mc-queue'             => resource[:track_egress_mc_queue],
        'track-peak-stats'                  => resource[:track_peak_stats],
        'track-ingress-port-priority-group' => resource[:track_ingress_port_priority_group],
        'track-egress-service-pool'         => resource[:track_egress_service_pool],
        'track-device'                      => resource[:track_device]
      }
    params
  end

  def track_peak_stats=(_value)
    params = params_setup
    Puppet::Provider::Cnos.set_bst_tracking(params)
  end

  def track_egress_port_service_pool=(_value)
    params = params_setup
    Puppet::Provider::Cnos.set_bst_tracking(params)
  end

  def track_egress_uc_queue=(_value)
    params = params_setup
    resp = Puppet::Provider::Cnos.set_bst_tracking(params)
  end

  def track_egress_rqe_queue=(_value)
    params = params_setup
    Puppet::Provider::Cnos.set_bst_tracking(params)
  end

  def track_egress_cpu_queue=(_value)
    params = params_setup
    resp = Puppet::Provider::Cnos.set_bst_tracking(params)
  end

  def track_ingress_port_service_pool=(_value)
    params = params_setup
    resp = Puppet::Provider::Cnos.set_bst_tracking(params)
  end

  def track_ingress_service_pool=(_value)
    params = params_setup
    Puppet::Provider::Cnos.set_bst_tracking(params)
  end

  def track_egress_mc_queue=(_value)
    params = params_setup
    Puppet::Provider::Cnos.set_bst_tracking(params)
  end

  def track_ingress_port_priority=(_value)
    params = params_setup
    Puppet::Provider::Cnos.set_bst_tracking(params)
  end

  def track_egress_service_pool=(_value)
    params = params_setup
    Puppet::Provider::Cnos.set_bst_tracking(params)
  end

  def track_device=(_value)
    params = params_setup
    Puppet::Provider::Cnos.set_bst_tracking(params)
  end
  
  def exists?
    Puppet.debug('I am inside exists')
    @property_hash[:ensure] == :present
    true
  end

end
