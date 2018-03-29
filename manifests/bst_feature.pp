# Copyright (c) 2017, Lenovo. All rights reserved.
#
# This program and the accompanying materials are licensed and made available
# under the terms and conditions of the 3-clause BSD License that accompanies 
# this distribution. The full text of the license may be found at

# https://opensource.org/licenses/BSD-3-Clause

# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, WITHOUT
# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.

# This class is used to get and set BST Feature 
#
# This is an example of how to make this telemtry configuration.
# If you change ensure to 'absent', it will set all the values to device defaults.
# You can change all the parameters of this association using this class
#
# @example Declaring the class
#   include cnos_telemetry
#
# @param [String] name The value is bst_feature.
# @property [Integer] collection_interval The collection interval, in seconds
# @property [Integer] send_async_reports To enable the transmission of periodic asynchronous reports
# @property [Integer] send_snapshot_on_trigger To enable sending a complete snapshot
# @property [Integer] trigger_rate_limit The trigger rate limit,
# @property [Integer] async_full_report Set the async full report feature
# @property [Integer] trigger_rate_limit_interval The trigger rate limit interval
# @property [Integer] bst_enable Set to 1 to enable BST, 0 to disable it.

class cnos::bst_feature {
  cnos_telemetry{ 'bst_feature':
    ensure                      => 'present',
    collection_interval         => 70,
    send_async_reports          => 0,
    send_snapshot_on_trigger    => 1,
    trigger_rate_limit          => 1,
    async_full_report           => 1,
    trigger_rate_limit_interval => 10,
    bst_enable                  => 0,
  }
}
