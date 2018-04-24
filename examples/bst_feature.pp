# CNOS BST Feature example

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
