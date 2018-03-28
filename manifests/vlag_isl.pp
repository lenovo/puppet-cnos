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

# This class provides setting of VLAG Instance configurations
#
# This is an example to show how to set the port aggregator 
# This class allows you to set port-aggregator value only.
# Rest of the attributes including delete options will 
# be implemented in later releases to this class.
#
# @example Declaring the class
#   include cnos_vlag_isl
#
# @param [String] name Its defined as vlag_isl.
# @property [Integer] msg_interval The interval with which heartbeat messages sent.
# @property [Integer] port_aggregator LAG identifier; an integer from 1-4096.

class cnos::vlag_isl {
  cnos_vlag_isl {'vlag_isl':
    port_aggregator => 10
  }
}
