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

Puppet::Type.type(:cnos_telemetry_track).provide :bst_track do
  desc 'Manage BST Tracking on Lenovo CNOS. Requires cnos-rbapi'

  confine operatingsystem: [:ubuntu]

  def track_device
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_tracking(conn)
    resp['track-device']
  end

  def track_egress_port_service_pool
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_tracking(conn)
    resp['track-egress-port-service-pool']
  end

  def track_egress_uc_queue
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_tracking(conn)
    resp['track-egress-uc-queue']
  end

  def track_egress_rqe_queue
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_tracking(conn)
    resp['track-egress-rqe-queue']
  end

  def track_egress_cpu_queue
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_tracking(conn)
    resp['track-egress-cpu-queue']
  end

  def track_egress_mc_queue
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_tracking(conn)
    resp['track-egress-mc-queue']
  end

  def track_egress_service_pool
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_tracking(conn)
    resp['track-egress-service-pool']
  end

  def track_ingress_service_pool
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_tracking(conn)
    resp['track-ingress-service-pool']
  end

  def track_ingress_port_service_pool
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_tracking(conn)
    resp['track-ingress-port-service-pool']
  end

  def track_ingress_port_priority_group
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_tracking(conn)
    resp['track-ingress-port-priority-group']
  end

  def track_peak_stats
    conn = Connect.new('./config.yml')
    resp = Telemetry.get_bst_tracking(conn)
    puts "here"
    resp['track-peak-stats']
  end

  def params_setup
    params =
      {
        "track-egress-port-service-pool" => resource[:track_egress_port_service_pool],
        "track-egress-uc-queue" => resource[:track_egress_uc_queue],
        "track-egress-rqe-queue" => resource[:track_egress_cpu_queue],
        "track-egress-cpu-queue" => resource[:track_egress_cpu_queue],
        "track-ingress-port-service-pool" => resource[:track_ingress_port_service_pool],
        "track-ingress-service-pool" => resource[:track_ingress_service_pool],
        "track-egress-mc-queue" => resource[:track_egress_mc_queue],
        "track-peak-stats" => resource[:track_peak_stats],
        "track-ingress-port-priority-group" => resource[:track_ingress_port_priority_group],
        "track-egress-service-pool" => resource[:track_egress_service_pool],
        "track-device" => resource[:track_device]
      }
    return params
  end

  def track_peak_stats=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_tracking(conn, params)
  end

  def track_egress_port_service_pool=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_tracking(conn, params)
  end

  def track_egress_uc_queue=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_tracking(conn, params)
  end

  def track_egress_rqe_queue=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_tracking(conn, params)
  end

  def track_egress_cpu_queue=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_tracking(conn, params)
  end

  def track_ingress_port_service_pool=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_tracking(conn, params)
  end

  def track_ingress_service_pool=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_tracking(conn, params)
  end

  def track_egress_mc_queue=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_tracking(conn, params)
  end

  def track_ingress_port_priority=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_tracking(conn, params)
  end

  def track_egress_service_pool=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_tracking(conn, params)
  end

  def track_device=(value)
    conn = Connect.new('./config.yml')
    params = params_setup
    resp = Telemetry.set_bst_tracking(conn, params)
  end
end
