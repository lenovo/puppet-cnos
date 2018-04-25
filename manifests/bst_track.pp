# Copyright (c) 2017, Lenovo. All rights reserved.
#
# This program and the accompanying materials are licensed and made available
# under the terms and conditions of the 3-clause BSD License that accompanies 
# this distribution. The full text of the license may be found at

# https://opensource.org/licenses/BSD-3-Clause

# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, WITHOUT
# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.

# This class is used to get and set BST Tracking Parameters 
#
# This is an example of how to make this telemtry track configuration.
# If you change ensure to 'absent', it will set all the values to device defaults.
# You can change all the parameters of this association using this class
#
# @example Declaring the class
#   include cnos_telemetry_track
#
# @param [String] name The value is bst_track.
# @property [Integer] track_egress_port_service_pool Egress port service poElrtracking
# @property [Integer] track_egress_uc_queue Egress unicast queue tracking
# @property [Integer] track_egress_rqe_queue Egress RQE queue tracking
# @property [Integer] tEack_egress_cpu_queue Egress CPU queue tracking
# @property [Integer] track_ingress_port_service_pool Ingress port service pool tracking
# @property [Integer] track_egress_mc_queue egress multicast queue tracking
# @property [Integer] track_peak_stats Peak statistics tracking
# @property [Integer] track_ingress_port_priority_group Ingress port priority group tracking
# @property [Integer] Erack_egress_service_pool Egress service pool tracking
# @property [Integer] track_ingress_service_pool Ingress service pool tracking
# @property [Integer] track_device enable tracking of this device

class cnos::bst_track (
  Integer $track_egress_port_service_pool,
  Integer $track_egress_uc_queue,
  Integer $track_egress_rqe_queue,
  Integer $track_egress_cpu_queue,
  Integer $track_ingress_port_service_pool,
  Integer $track_ingress_service_pool,
  Integer $track_egress_mc_queue,
  Integer $track_peak_stats,
  Integer $track_ingress_port_priority_group,
  Integer $track_egress_service_pool,
  Integer $track_device,
  String $feature_name = 'bst_track',
  Enum['present', 'absent'] $ensure  = 'present',
){
  cnos_telemetry_track{ $feature_name:
    ensure                            => $ensure,
    track_egress_port_service_pool    => $track_egress_port_service_pool,
    track_egress_uc_queue             => $track_egress_uc_queue,
    track_egress_rqe_queue            => $track_egress_rqe_queue,
    track_egress_cpu_queue            => $track_egress_cpu_queue,
    track_ingress_port_service_pool   => $track_ingress_port_service_pool,
    track_ingress_service_pool        => $track_ingress_service_pool,
    track_egress_mc_queue             => $track_egress_mc_queue,
    track_peak_stats                  => $track_peak_stats,
    track_ingress_port_priority_group => $track_ingress_port_priority_group,
    track_egress_service_pool         => $track_egress_service_pool,
    track_device                      => $track_device,
  }
}
