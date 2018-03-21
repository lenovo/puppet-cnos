# Copyright (c) 2017, Lenovo. All rights reserved.
#
# This program and the accompanying materials are licensed and made available
# under the terms and conditions of the 3-clause BSD License that accompanies 
# this distribution. The full text of the license may be found at

# https://opensource.org/licenses/BSD-3-Clause

# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, WITHOUT
# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.

class cnos::bst_feature {
  cnos_telemetry{ 'bst_feature':
    collection_interval         => 70,
    send_async_reports          => 0,
    send_snapshot_on_trigger    => 1,
    trigger_rate_limit          => 1,
    async_full_report           => 1,
    trigger_rate_limit_interval => 10,
    bst_enable                  => 0,
  }
}
