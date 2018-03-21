# Copyright (c) 2017, Lenovo. All rights reserved.
#
# This program and the accompanying materials are licensed and made available
# under the terms and conditions of the 3-clause BSD License that accompanies 
# this distribution. The full text of the license may be found at

# https://opensource.org/licenses/BSD-3-Clause

# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, WITHOUT
# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.

class cnos::bst_track {
  cnos_telemetry_track{'bst':
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
