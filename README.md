# CNOS

#### Table of Contents


1. [Module Description - What the module does and why it is useful](#module-description)
1. [Setup - The basics of getting started with cnos](#setup)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - CNOS Versions, GEM dependency, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)


## Module description

This module uses REST to manage various Network management features of Switches running Lenovo CNOS and acts as a foundation for building higher level abstractions within Puppet. 
The CNOS module provides a set of types, providers and resources for managing Lenovo CNOS switches. 
These include resources for VLAN provisioning, VLAG, ARP, Telemetry, LAG, LACP, IP-Interface Mapping, VLAN-Port Mapping etc.


## Setup

### Beginning with CNOS Module in puppet

Before you can use the CNOS module, you must create a proxy system able to run puppet device. 
Your Puppet agent will serve as the proxy for the puppet device subcommand.


## Usage


### Installation Requirements 

The following infrastructure is required for the use of CNOS module:

1. A server running as a Puppet Master
2. A Puppet Agent running as a Puppet Device proxy to the CNOS device (switch)
3. A CNOS device (switch) running firmware version 10.6 or later

### Installation and Configuration Steps

1.  Install Puppet CNOS Module on Puppet Master
2.  Install CNOS and Rest-Client gems on Puppet Agent, running as proxy to the CNOS device (switch)
3.  Create a device.conf file on the Puppet Agent node with details of the CNOS device (switch)
4.  Run Puppet Device command on the Puppet Agent to initiate registration with the Puppet Master
5.  Creating, Updating and Applying Manifests (Resources) to create a catalog on Puppet Master
6.  Classify the CNOS device to the applied Manifests (Resources) from PE console
7.  Run Configuration Task to the CNOS device (switch) per Catalog from Puppet Master

See below for the detailed steps.

#### Step One: Install Puppet CNOS Module on Puppet Master

To install the module run, 

puppet module install lenovo-cnos

#### Step Two: Install CNOS and Rest-Client gems on Puppet Agent

To install the gem files on Puppet Agent
 
/opt/puppetlabs/puppet/bin/gem install rest-client

/opt/puppetlabs/puppet/bin/gem install lenovo-rbapi -v 0.0.5

To handle rest-client and lenovo-rbapi gem dependencies on Puppet Agent, 'Package' resource is used for reference gems on init.pp manifest file on Puppet Master under CNOS Module path. Sample manifest looks like;

```ruby
class cnos::install {
 if $::puppetversion and $::puppetversion =~ /Puppet Enterprise/ {
   $provider = 'pe_gem'
 } elsif $::puppetversion and versioncmp($::puppetversion, '4.0.0') >= 0 {
   $provider = 'puppet_gem'
 } else {
   $provider = 'gem'
 }
 package { 'lenovo-rbapi':
   ensure   => '0.0.5',
   provider => $provider,
 }
package { 'rest-client' :
   ensure => '2.0.2',
   provider => 'puppet_gem',
 }
}
```

#### Step Three: Create a device.conf file on the Puppet Agent

Create a device.conf file in the /etc/puppetlabs/puppet/ directory on Puppet Agent with details of the CNOS device (switch)
```ruby
[<FQDN of Switch>]
type cnos
url https://<USERNAME>:<PASSWORD>@<IP ADDRESS OF CNOS Switch>/
```
In the above example, 
<USERNAME> and <PASSWORD> refer to Puppet's login for the device
FQDN refers to Fully Qualified Domain Name of the switch 

NOTE: Make sure the Switch is reachable by its FQDN from the Master and Agent instance


#### Step Four: Run Puppet Device command on the Puppet Agent

Run the following command on Puppet Agent to have the device proxy node generate a certificate for the device (switch)
```ruby
puppet device -v
```
Verify the device (switch) FQDN with SSL certificate information is listed on the output of following command on Puppet Master
```ruby
puppet cert list --all
```

Sign the device (switch) SSL certificate on Puppet Master
```ruby
puppet cert sign <device FQDN>
puppet cert list --all
```


#### Step Five: Updating and Applying Manifests (Resources)

Manifests are available at /etc/puppetlabs/code/environment/production/modules/cnos/manifests/
Modify existing manifest to your network configuration requirements (for eg: For VLAN - vlan id, name and admin_state)

Sample Manifest
```ruby
class cnos::vlan {
  cnos_vlan { '11':
    ensure      => 'present',
    admin_state => 'down',
    vlan_name   => 'test11',
  }
}
```

#### Step Six: Classify the CNOS device

Open Puppet Enterprise (PE) Console using https://<FQDN of Puppet Master>/ and enter credentials created during Puppet Enterprise Installation
Click on Classification under Configure section and select the Manifests (Resource - cnos::<class>) and Node (switch/device)

#### Step Seven: Run Configuration Tasks to the CNOS device from Puppet Agent

Run the following commands on Puppet Agent
```ruby
puppet agent --test
puppet device -v --user=root
```

## Reference

### Classes

#### Public classes

### cnos::arp

Handles Arp on Lenovo CNOS for interfaces.
For details regarding parameters, please refer to [cnos_arp](#cnos_arp).

#### Sample Manifest 
```ruby
class cnos::arp {
  cnos_arp{'Ethernet1/13':
    ageout_time => 1500,
  }
}
```
### cnos::arp_sys

Handles Arp on Lenovo CNOS for system
For details regarding parameters, please refer to [cnos_arp_sys](#cnos_arp).

#### Sample Manifest 
```ruby
class cnos::arp_sys {
  cnos_arp_sys{'arp_sys':
    ageout_time => 1000
  }
}
```
### cnos::bst_feature

Handles  BST feature on Lenovo CNOS.
For details regarding parameters, please refer to [cnos_telemetry](#cnos_telemetry).

#### Sample Manifest 
```ruby
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
```

### cnos::bst_track

Handles BST Tracking on Lenovo CNOS.
For details regarding parameters, please refer to [cnos_telemetry_track](#cnos_telemetry_track).

#### Sample Manifest 
```ruby
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
```

### cnos::ip_intf

Handles IP interfaces on Lenovo CNOS
For details regarding parameters, please refer to [cnos_ip_intf](#cnos_ip_intf).

#### Sample Manifest 
```ruby
class cnos::ip_intf {
  cnos_ip_intf{'Ethernet1/11':
    ensure        => present,
    ip_addr       => '1.2.3.4',
    bridge_port   => 'no',
    if_name       => 'Ethernet1/11',
    mtu           => 1402,
    vrf_name      => 'default',
    admin_state   => 'up',
    ip_prefix_len => 24
  }
}
```

### cnos::cnos::lacp

Handles Lacp on Lenovo CNOS
For details regarding parameters, please refer to [cnos_lacp](#cnos_lacp).

#### Sample Manifest 
```ruby
class cnos::lacp {
  cnos_lacp {'sys_prio':
    sys_prio => '32769',
  }
}
```

### cnos::cnos::lag

Handles lag on Lenovo CNOS
For details regarding parameters, please refer to [cnos_lag](#cnos_lag).

#### Sample Manifest 
```ruby
class cnos::lag {
  cnos_lag { '11':
    ensure     => 'present',
    interfaces =>  [ {
      'lacp_prio'    => 32769,
      'lacp_timeout' => 'long',
      'lag_mode'     => 'lacp_active',
      'if_name'      => 'Ethernet1/23',
    }],
    min_links  => 2,
  }
}
```

### cnos::cnos::sys

Handles Telemetry System properties on Lenovo CNOS
For details regarding parameters, please refer to [cnos_sys](#cnos_sys).

#### Sample Manifest 
```ruby
class cnos::sys {
  cnos_sys{'sys':
    ensure           => present,
    msg_interval     => 15,
    heartbeat_enable => 1
  }
}
```

### cnos::cnos::vlag_health

Handles Vlag_health on Lenovo CNOS
For details regarding parameters, please refer to [cnos_vlag_health](#cnos_vlag_health).

#### Sample Manifest 
```ruby
class cnos::vlag_health {
  cnos_vlag_hc {'vlag':
    ensure             => absent,
    keepalive_interval => 5,
    retry_interval     => 10,
    keepalive_attempts => 15,
  }
}

```

### cnos::cnos::vlag_isl

Handles vlag isl on Lenovo cnos
For details regarding parameters, please refer to [cnos_vlag_isl](#cnos_vlag_isl).

#### Sample Manifest 
```ruby
class cnos::vlag_isl {
  cnos_vlag_isl {'vlag_isl':
    port_aggregator => 10
  }
}

```

### cnos::cnos::vlag

Handles Vlags on Lenovo cnos.
For details regarding parameters, please refer to [cnos_vlag](#cnos_vlag).

#### Sample Manifest 
```ruby
class cnos::vlag {
  cnos_vlag { '2':
    ensure          => 'present',
    status          => 'disable',
    port_aggregator => 20,
  }
}

```

### cnos::cnos::vlan_intf

Handles Vlan -Interface mapping on Lenovo cnos.
For details regarding parameters, please refer to [cnos_vlan_intf](#cnos_vlan_intf).

#### Sample Manifest 
```ruby
class cnos::vlan_intf {
  cnos_vlan_intf { 'Ethernet1/92':
    ensure          => 'present',
    bridgeport_mode => 'trunk',
    pvid            => 1,
    vlans           => [10],
  }
}
```

### cnos::cnos::vlan

Handles VLAN on Lenovo cnos.
For details regarding parameters, please refer to [cnos_vlan](#cnos_vlan).

#### Sample Manifest 
```ruby
class cnos::vlan {
  cnos_vlan { '11':
    ensure      => 'present',
    admin_state => 'down',
    vlan_name   => 'test11',
  }
}

```

### cnos::cnos::vrrp

Handles Vrrp on Lenovo cnos.

For details regarding parameters, please refer to [cnos_vrrp](#cnos_vrrp).

#### Sample Manifest 
```ruby
class cnos::vrrp {
  cnos_vrrp{ '1' :
    ensure            => present,
    prio              => 99,
    vr_id             => 1,
    if_name           => 'Ethernet1/11',
    preempt           => 'no',
    admin_state       => 'down',
    ip_addr           => '1.1.1.2',
    switch_back_delay => 1,
    accept_mode       => 'no',
    v2_compt          => 'no',
    ad_intvl          => 200,
  }
}

```

#### Private classes

None.


#### Types

* [cnos_arp](#cnos_arp): Manage ARP properties on interfaces of Lenovo cnos.
* [cnos_arp_sys](#cnos_arp_sys): Manage Arp propertiesof system on Lenovo cnos.
* [cnos_ip_intf](#cnos_ip_intf): Manage Ip intf on Lenovo cnos.
* [cnos_lacp](#cnos_lacp): Manage Lacp on Lenovo cnos.
* [cnos_lag](#cnos_lag): Manage lags on Lenovo cnos.
* [cnos_sys](#cnos_sys): Manage Telemetry system properties on Lenovo cnos.
* [cnos_telemetry](#cnos_telemetry): Manage Telemetry feature on Lenovo cnos.
* [cnos_telemetry_track](#cnos_telemetry_track): Manage Telemetry tracking on Lenovo cnos.
* [cnos_vlag_conf](#cnos_vlag_conf): Manage Vlag Configuration on Lenovo cnos.
* [cnos_vlag_hc](#cnos_vlag_hc): Manage Vlag Health on Lenovo cnos.
* [cnos_vlag_isl](#cnos_vlag_isl): Manage vlag isl on Lenovo cnos.
* [cnos_vlag](#cnos_vlag): Manage Vlags on Lenovo cnos.
* [cnos_vrrp](#cnos_vrrp): Manage Vrrp on Lenovo cnos.
* [cnos_vlan_intf](#cnos_vlan_intf): Manage Vlan -Interface mapping on Lenovo cnos.
* [cnos_vlan](#cnos_vlan): Manage Vlans on Lenovo cnos.

### cnos_arp

Manage ARP properties on interfaces of Lenovo cnos.

#### Parameters

##### if_name 

IP interface name.

Valid options: String

Note: The interface must exist.

#### Properties

##### ageout_time

The global ARP entry age-out time, in seconds

Valid options: An integer from 60-28800. Default value: 1500 seconds.


### cnos_arp_sys

Manage Arp properties of system on Lenovo cnos.

#### Parameters

##### title 

Name of parameter

Valid options: None

#### Properties

##### ageout_time

The global ARP entry age-out time, in seconds

Valid options: An integer from 60-28800. Default value: 1500 seconds.

### cnos_ip_intf

Manage Ip intf on Lenovo cnos.

#### Parameters

##### if_name

Ethernet interface name

Valid options: Valid String
Note: The interface must exist.

#### Properties

##### vrf_name

The name of the VRF to which the interface belongs.

Valid options: String
Note: The named VRF must exist.

##### bridge_port

Whether or not the port is a bridge port.

Valid options: One of yes (default), no.

##### mtu

The maximum transmission unit, in bytes.

Valid options: An integer from 64-9216. Default value: 1500.


##### ip_addr

IP address for the interface.

Valid options: IP Address
   
##### ip_prefix_len

IP address mask.

Valid options: A positive integer from 1-32.

##### admin_state

The admin status.

Valid options: One of up, down.


### cnos_lacp

Manage Lacp on Lenovo cnos.

#### Parameters

##### title

Name of parameter.

Valid options: None

#### Properties

##### sys_prio

LACP priority for the physical port.

Valid options: An integer from 1-65535. Default value: 32768.

### cnos_lag

Manage lags on Lenovo cnos.

#### Parameters

##### lag_id

LAG identifier.

Valid options: An integer from 1-65535

#### Properties

##### interfaces

Array of interfaces dictionary. 

Valid options: Physical interface members of the LAG; an integer from 1-32.

##### min_links

LACP minimum links number.

Valid options: An integer from 1-32. Default value: 1

### cnos_sys

Manage Telemetry system properties on Lenovo cnos.

#### Parameters

##### sys_feature

Setting system feature - should be "sys"

Valid options: sys.

#### Properties

##### heartbeat_enable

When enabled, the Agent asynchronously sends the registration
and heartbeat message to the collector. 

Valid options: One of: 0: disable heartbeat 1: enable heartbeat (default value)

##### msg_interval

Determines the interval with which the registration and heartbeat
messages are sent to the collector; units of seconds from 1-600.
Default value: 5 seconds.

Valid options: See above.


### cnos_telemetry

Manage Telemetry feature on Lenovo cnos

#### Parameters

##### bst_feature

setting bst feature - should be "bst

Valid options: None.

#### Properties

##### bst_enable

Set to 1 to enable BST, 0 to disable it. Enabling BST
allows the switch to track buffer utilization
statistics.

Valid options: See above.

##### send_async_reports

Set to 1 to enable the transmission of periodic
asynchronous reports, 0 to disable this feature.   

Valid options: See above.

##### async_full_report

Set to 1 to enable the async full report feature, 0 to
disable it.

Valid options: See above.
Note : When this feature is enabled, the agent sends full
reports containing data related to all counters.
When the feature is disabled, the agent sends
incremental reports containing only the counters
that have changed since the last report.

##### collection_interval

The collection interval, in seconds. This defines how
frequently periodic reports will be sent to the
configured controller.

Valid options: See above.

##### trigger_rate_limit

The trigger rate limit, which defines the maximum
number of threshold-driven triggered reports that
the agent is allowed to send to the controller per
trigger-rate-limit-interval; an integer
from 1-5.
Valid options: See above

##### trigger_rate_limit_interval

The trigger rate limit interval, in seconds; an integer
from 10-60.

Valid options: See above.

##### send_snapshot_on_trigger

Set to 1 to enable sending a complete snapshot of all
buffer statistics counters when a trigger happens, 0
to disable this feature.

Valid options: See above

##### async_full_reports

Set to 1 to enable the async full report feature, 0 to
disable it.
Valid options: See above.
Note: When this feature is enabled, the agent sends full
reports containing data related to all counters.
When the feature is disabled, the agent sends
incremental reports containing only the counters
that have changed since the last report.


### cnos_telemetry_track

Manage Telemetry tracking on Lenovo cnos

#### Parameters

##### bst_track

Setting bst tracking - should be "bst

Valid options: bst

#### Properties

##### track_peak_stats

1 to peak statistics tracking, 0 to disable this
feature
Valid options: See above.

##### track_ingress_port_priority_group

1 to enable ingress port priority group tracking,
0 to disable this feature

Valid options: See above.

##### track_ingress_port_service_pool

1 to enable ingress port service pool tracking, 0
to disable this feature

Valid options: See above.

##### track_ingress_service_pool

1 to enable ingress service pool tracking, 0 to
disable this feature

Valid options: See above.

##### track_egress_port_service_pool

1 to enable egress port service pool tracking, 0
to disable this feature

Valid options: See above

##### track_egress_service_pool

1 to enable egress service pool tracking, 0 to
disable this feature

Valid options: See above.

##### track_egress_uc_queue

Set to 1 to enable egress unicast queue tracking,
0 to disable this feature

Valid options: See above.

##### track_egress_rqe_queue

1 to enable egress RQE queue tracking, 0 to
disable this feature

Valid options: See above.

##### track_egress_cpu_queue

Set to 1 to enable egress CPU queue tracking, 0
to disable this feature

Valid options: See above.

##### track_egress_mc_queue

Set to 1 to enable egress multicast queue
tracking, 0 to disable this feature

Valid options: See above.

##### track_device

1 to enable tracking of this device, 0 to disable
this feature

Valid options: See above


### cnos_vlag_conf

Manage Vlag Configuration on Lenovo cnos

#### Parameters

##### title

name of parameter

Valid options: None.

#### Properties

##### status

Whether the vLAG is enabled or disabled.

Valid options: One of enable, disable. Default value; disable

##### tier_id

vLAG tier ID value.

Valid options: An intger from 1-512. Default value: 0.

##### priority

vLAG priority value.

Valid options: An integer from 0-65535. Default value: 0.

##### auto_recover

Time interval, in seconds.

Valid options: An integer from 240-3600. Default value: 300.

##### startup_delay

Delay time, in seconds.

Valid options: An integer from 0-3600. Default value: 120.

### cnos_vlag_hc

Manage Vlag Health on Lenovo cnos.

#### Parameters

##### title

name of parameter

Valid options: None.

#### Properties

##### peer_ip

IP address of peer switch. This can be the management IP address
of the peer switch.

Valid options: IP Address.

##### vrf

VRF context string.

Valid options: String.

##### keepalive_attempts

Number of keepalive attempts made before declaring the peer is
down.

Valid options: An integer from 1-24. Default value: 3.

##### keepalive_interval

Time interval, in seconds

Valid options: an integer from 2-300. Default value: 5.

##### retry_interval

Time interval, in seconds. 

Valid options: An integer from 1-300. Default value:30.


### cnos_vlag_isl

Manage vlag isl on Lenovo cnos.

#### Parameters

##### title

name of parameter

Valid options: None.

#### Properties

##### port_aggregator

LAG identifier.

Valid options: An integer from 1-4096.

### cnos_vlag

Manage Vlags on Lenovo cnos. 

#### Parameters

##### inst_id

vLAG instance ID number.

Valid options: An integer from 1-64.

#### Properties

##### port_aggregator

LAG identifier.

Valid options: An integer from 1-4096.

#### status

vLAG status.

Valid range: One of enable, disable. Default value: disable.

### cnos_vrrp

Manage Vrrp on Lenovo cnos. 

#### Parameters

##### vr_id

The VRRP session Virtual Router (VR) ID.

Valid options: An integer from 1-255. Default value is 0.

##### if_name

Interface name.

Valid options: A valid interface name.

Note: The interface must exist.

#### Properties

##### ad_intvl

Advertisement interval (The number of centi-seconds between
advertisements for VRRPv3);

Valid options: a multiple of 5 from 5-4095. Default value: 100 centi-seconds.

#### preempt

Enable the preemption of a lower priority master

Valid range: of yes (default) , no.

##### prio

The priority of the VR on the switch

Valid options: An integer from 1-254.Default value: 100.

##### admin_state

Enable the VR

Valid options: one of up (default), down.

##### track_if

The interface to track by this VR

Valid options: Default value: none.
Note: If an interface is specified, it must exist.

##### admin_state

Enable the VR

Valid options: one of up (default), down.

##### track_if

The interface to track by this VR

Valid options: Default value: none.
Note: If an interface is specified, it must exist.

##### accept_mode

Enables or disables the accept mode for this session. 

Valid options: one of yes (default), no.

##### v2_compt

Enables backward compatibility for VRRPv2 for the VR

Valid options: one of yes, no (default).

##### switch_back_delay

The switch back delay interval

Valid options: an integer from 1-500000, or 0 to disable (default).

### cnos_vlan_intf

Manage Vlan -Interface mapping on Lenovo cnos. 

#### Parameters

##### if_name

Ethernet interface name.

Valid options: A valid Ethernet interface name.

Note: The Ethernet interface must exist.

#### Properties

##### bridgeport_mode

Sets the bridgeport mode value.

Valid options: 'access' or 'trunk'.

#### pvid

Native VLAN for a port (he access VLAN for access ports or the
native VLAN for trunk ports).

Valid range: an integer from 1-3999. Default value is 1

##### vlans

VLAN memberships

Valid options: either all, none, or an integer from 1-3999

### cnos_vlan

Manages virtual LANs on the CNOS device. 

#### Parameters

##### name

Specifies the Name of VLAN.

Valid options: The name must be between 1 and 64 characters long.

#### Properties

##### vlan_id

Sets the vlan id.

Valid options: An integer value within limit (1-3999).

#### vlan_name

Specifies the Name of VLAN.

Valid range: The name must be between 1 and 64 characters long.

##### admin_state

Specifies the state of vlan.

Valid options: 'up' or 'down'.


## Limitations

Lenovo CNOS version v10.4 or greater.
Puppet Enterprise: 5.4.0 or greater.
Lenovo Ruby Gem (lenovo-rbapi) : 0.0.5 or greater

## Development

Puppet modules on the Puppet Forge are open projects, and community contributions are essential for keeping them great. Please follow our guidelines when contributing changes.
For more information, see our [module contribution guide.](https://docs.puppetlabs.com/forge/contributing.html)

## Support

Support for this module is provided by Lenovo.  To file an issue, please visit this [link](https://github.com/lenovo/puppet-cnos/issues/new)
