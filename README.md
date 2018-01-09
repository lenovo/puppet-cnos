# puppet-cnos
This contains modules that supports configurations of cnos devices through puppet

#### Table of Contents

1. [Description](#description)
1. [Manifests](#manifests)
1. [Dependencies](#dependencies)
1. [Running the manifests](#running-the-manifests)
1. [Testing](#testing)
1. [Contributors](#contrinutors)
1. [License](#license)

## Description

The cnos module provides a set of types and providers for managing Lenovo switches. The module provides resources for the VLAN provisioning, Vlag provisioning, Arp, Tel
emetry, etc . The manifests use the CNOS Ruby APIs (Ruby GEM) to communicate with the switch OS and configure them..

## Manifests

Below are given a few examples of manifests that make use of the types and providers

### 1.vlan
This manifests creates vlan if it does not exist or if the vlan exists the manifest updates the vlan state as given by the parameters.
```ruby
cnos_vlan { '11':
ensure => 'present',
admin_state => 'down',
vlan_name => 'test11',}
```
### 2.vlag
This manifests creates vlag if it does not exist or if the vlag exists the manifest updates the vlag state as given by the parameters.
```ruby
cnos_vlag { '2':
ensure => 'present',
status => 'disable',
port_aggregator => 20,}
```
### 3.vrrp
This manifests creates vrrp vr if it does not exist or if the vrrp vr exists the manifest updates the vrrp state as given by the parameters.
```ruby
cnos_vrrp{ '1' :
         ensure => 'present',
         prio =>  100,
         vr_id =>  1,
         if_name =>  'Ethernet1/1',
         track_if =>  'Ethernet1/2',
         preempt =>  'no',
         admin_state =>  'down',
         ip_addr =>  '1.1.1.254',
         switch_back_delay =>  1,
         accept_mode =>  'no',
         v2_compt =>  'no',
         ad_intvl =>  100
}
```
**Note** - All the above recipes require the config file to reside on the client.

## Dependencies
* Puppet 4.10 or later
* Lenovo CNOS 10.4 or later
* rest-client

## Running the manifest
1. Install puppet-agent on the node
2. Install Lenovo CNOS Ruby GEM in the same node
3. Create switch.yml for each Lenovo device/agent to be configured see below example file

```yaml
transport : 'http' #http or https
port : '8090' #8090 or 443
ip : 'switch ip address' #Switch IP address
user : '<user>' #Credentials
password : '<password>' #Credentials
```
4. Install puppet-cnos module on the agent
5. Run 'puppet apply' on node with the required manifest or add it as a cron job

## Testing
The cookbook was originally tested direclty on a Ubuntu 16.04 VM, set up as client.
In the setup,
1. A config file 'switch.yml' was created on the agent.
2. 'cnos-rbapi' gem was installed.
3. Vlan Config, Vlag config, Vrrp, etc manifests(given as instances above) were tested on the VM and the configurations were verified

Unit test tools such as spec can also be used to test types and providers

## Contributors
* Lenovo DCG Networking, Lenovo

## License
Apache 2.0, See LICENSE file
