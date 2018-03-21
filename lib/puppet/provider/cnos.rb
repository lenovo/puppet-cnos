require File.join(File.dirname(__FILE__), '../util/network_device/cnos')
require File.join(File.dirname(__FILE__), '../util/network_device/transport/cnos')
require 'cnos-rbapi/vlan'
require 'cnos-rbapi/vrrp'
require 'cnos-rbapi/vlan_intf'
require 'cnos-rbapi/vlag'
require 'cnos-rbapi/arp'
require 'cnos-rbapi/ip_intf'
require 'cnos-rbapi/lacp'
require 'cnos-rbapi/lag'
require 'cnos-rbapi/telemetry'
require 'json'

class Puppet::Provider::Cnos < Puppet::Provider
  def self.device(url)
    Puppet::Util::NetworkDevice::Cnos::Device.new(url)
  end

  def self.transport
    if Puppet::Util::NetworkDevice.current
      # we are in `puppet device`
      Puppet::Util::NetworkDevice.current.transport
    else
      # we are in `puppet resource`
      Puppet::Util::NetworkDevice::Transport::Cnos.new(Facter.value(:url))
    end
  end

  def self.device_url
    Puppet::Util::NetworkDevice.current ? Puppet::Util::NetworkDevice.current.url.to_s : Facter.value(:url)
  end

  def self.connection
    transport.connection
  end

  # System methods start here
  def self.get_sys_feature
    resp = Telemetry.get_sys_feature(connection)
    resp
  end

  def self.set_sys_feature(params)
    resp = Telemetry.set_sys_feature(connection, params)
    resp
  end

  # Telemetry
  def self.get_bst_feature
    resp = Telemetry.get_bst_feature(connection)
    resp
  end

  def self.set_bst_feature(params)
    resp = Telemetry.set_bst_feature(connection, params)
  end

  def self.get_bst_tracking
    resp = Telemetry.get_bst_tracking(connection)
    resp
  end

  def self.set_bst_tracking(params)
    resp = Telemetry.set_bst_tracking(connection, params)
  end

  # LAG Methods start here
  def self.get_lag_prop(lag_id)
    resp = Lag.get_lag_prop(connection, lag_id)
    resp
  end

  def self.update_lag(lag_id, params)
    resp = Lag.update_lag(connection, lag_id, params)
    resp
  end

  def self.create_lag(lag_id, interfaces)
    Lag.create_lag(connection, lag_id, interfaces)
  end

  def self.delete_lag(lag_id)
    Lag.delete_lag(connection, lag_id)
  end

  # LACP Methods start here
  def self.get_lacp
    resp = Lacp.get_lacp(connection)
    resp
  end

  def self.update_lacp(params)
    resp = Lacp.update_lacp(connection, params)
    resp
  end

  # Interface Methods start here
  def self.get_ip_prop_all
    resp = Ipintf.get_ip_prop_all(connection)
    resp
  end

  def self.update_ip_prop_intf(if_name, params)
    resp = Ipintf.update_ip_prop_intf(connection, if_name, params)
    resp
  end

  # ARP Methods start here
  def self.get_arp_intf_prop(if_name)
    resp = Arp.get_arp_intf_prop(connection, if_name)
    resp
  end

  def self.set_arp_intf_prop(if_name, params)
    resp = Arp.set_arp_intf_prop(connection, if_name, params)
    resp
  end

  def self.get_arp_sys_prop
    resp = Arp.get_arp_sys_prop(connection)
    resp
  end

  def self.set_arp_sys_prop(params)
    resp = Arp.set_arp_sys_prop(connection, params)
    resp
  end

  # VLAG Methods start here
  def self.get_all_vlag
    resp = Vlag.get_all_vlag(connection)
    resp
  end

  def self.create_vlag_inst(params)
    resp = Vlag.create_vlag_inst(connection, params)
    resp
  end

  def self.update_vlag_inst(inst_id, params)
    resp = Vlag.update_vlag_inst(connection, inst_id, params)
    resp
  end

  def self.delete_vlag_inst(inst_id)
    resp = Vlag.delete_vlag_inst(connection, inst_id)
    resp
  end

  # VLAG Health Methods start here
  def self.get_vlag_health
    resp = Vlag.get_vlag_health(connection)
    resp
  end

  def self.update_vlag_health(params)
    resp = Vlag.update_vlag_health(connection, params)
    resp
  end

  # VLAG ISL Methods start here
  def self.get_vlag_isl
    resp = Vlag.get_vlag_isl(connection)
    resp
  end

  def self.update_vlag_isl(params)
    resp = Vlag.update_vlag_isl(connection, params)
    resp
  end

  # VLAG Conf Methods start here
  def self.get_vlag_conf
    resp = Vlag.get_vlag_conf(connection)
    resp
end

  def self.update_vlag_conf(params)
    resp = Vlag.update_vlag_conf(connection, params)
    resp
  end

  # VRRP Methods start here
  def self.get_vrrp_prop_all
    resp = Vrrp.get_vrrp_prop_all(connection)
    resp
  end

  def self.create_vrrp_intf(if_name, params)
    resp = Vrrp.create_vrrp_intf(connection, if_name, params)
    resp
  end

  def self.update_vrrp_intf_vrid(if_name, vr_id, params)
    resp = Vrrp.update_vrrp_intf_vrid(connection, if_name, vr_id, params)
    resp
  end

  def self.del_vrrp_intf_vrid(if_name, vr_id)
    resp = Vrrp.del_vrrp_intf_vrid(connection, if_name, vr_id)
    resp
  end

  # VLAN Starts here
  def self.get_all_vlan
    resp = Vlan.get_all_vlan(connection)
    resp
  end

  def self.create_vlan(params)
    resp = Vlan.create_vlan(connection, params)
    resp
  end

  def self.update_vlan(vlan_id, params)
    resp = Vlan.update_vlan(connection, vlan_id, params)
    resp
  end

  def self.delete_vlan(vlan_id)
    resp = Vlan.delete_vlan(connection, vlan_id)
    resp
  end

  # VLAN Interface Starts here
  def self.get_all_vlan_intf
    resp = VlanIntf.get_all_vlan_intf(connection)
    resp
  end

  def self.update_vlan_intf(if_name, params)
    resp = VlanIntf.update_vlan_intf(connection, if_name, params)
  end

  # Generic methods starts here``

  def self.call(url, args = {})
    transport.call(url, args)
  end

  def self.call_items(url, args = { 'expandSubcollections' => 'true' })
    if call = transport.call(url, args)
      call
      # call['item']
    end
  end

  def self.post(url, message)
    transport.post(url, message)
  end

  def self.put(url, message)
    transport.put(url, message)
  end

  def self.delete(url)
    transport.delete(url)
  end

  def self.find_availability(string)
    transport.find_availability(string)
  end

  def self.find_monitors(string)
    transport.find_monitors(string)
  end
end # End of class
