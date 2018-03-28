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

# This class provides setting of telemetry feature in a CNOS switch
#
# This is an example to show how to set the following telemtry 
# system feature attributes: heartbeat-enable and msg-interval
# If you change ensure to 'absent', it will reset this value to factory default
# The default value for heartbeat-enable is 1 and
# default value for msg-interval its 5 seconds
#
# @example Declaring the class
#   include cnos_sys
#
# @param [String] name Its defined as sys.
# @property [Integer] msg_interval The interval with which heartbeat messages sent.
# @property [Integer] heartbeat_enable The value is 0/1 for enable or disable

class cnos::sys {
  cnos_sys{'sys':
    ensure           => present,
    msg_interval     => 15,
    heartbeat_enable => 1
  }
}
