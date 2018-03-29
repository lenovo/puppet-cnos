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

class cnos::bst_track {
  cnos_telemetry_track{'bst_track':
    track_egress_port_service_pool    =>  0,
    track_egress_uc_queue             =>  0,
    track_egress_rqe_queue            =>  0,
    track_egress_cpu_queue            =>  0,
    track_ingress_port_service_pool   =>  0,
    track_ingress_service_pool        =>  0,
    track_egress_mc_queue             =>  0,
    track_peak_stats                  =>  1,
    track_ingress_port_priority_group =>  0,
    track_egress_service_pool         =>  0,
    track_device                      =>  0,
  }
}
