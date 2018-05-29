## 2018-05-29 Release 1.1.0

### Summary
Preparation of partner approved release.

## 2018-05-04 Release 1.0.0

### Summary
This release contains all the requirements for a valid Puppet module
All the bugs came up during testing has been resolved.
Tried to incorporate all review comments.

#### Features and Improvements
- Added example section which is tested with Lenovo G8272
- Added install.pp which will take care of dependency gem files
- Added variable declaration in every manifest files
- Added documentation in manifest
- Added validations to the types
- Changes in gem file to include the changes in type
- Added destroy method in all gem.rb

#### Fixed
- Removed rest-client gem from install.pp and added to README.md
- Modified metadata.json to take care of operating system support approriately.
- Removed hard tabs from metadata.json
- Scaffolded tests that doesnot apply to cnos are removed
- Ran rubocop and pdk to fix validation issues.
- Cleaned up manifest files to take care of user perspective.
- Removed API attributes from param to property
- Changes title to name as title is a puppet keyword
- Change in manifests accordingly
- Custom type tests are moved to spec/types
- Maintainers.md modified to take care of issues appropriately.

## 2018-02-26 Release 0.2.0

### Summary
This release removes the dependency of config.yml and added the code to the 
util/network_device folder so that facts are fetched for the device.
The transport layer which establishes with network device is realized
And a utilty file is created for provided to interract with devices using lenovo-rbapi.

#### Features
- Vlan Create, Update and Delete.
- Get and Set of Vlan properties on an Ethernet interface.
- Get and set properties of all VRRP VRs of interfaces.
- Get and Set the Virtual Link Aggregation Group (vLAG) global configuration.
- Create, Update and Delete of Vlag instances.
- Get and Set of vLAG health check information.
- Get and Set Virtual Link Aggregation Group (vLAG) Inter-Switch Link (ISL) information.
- Get and Set global ARP properties of the system
- Get and Set ARP properties of each interfaces
- Get and Set the LACP properties of the system.
- Create, Update and Delete of LAG
- Get and set IP properties of all interfaces or one interface.
- Get and set of telemetry system feature
- Get and set of telemetry BST feature
- Get and set of telemetry BST Tracking

#### Fixed
- PDK Validation issues are resolved

## 2018-01-24 Release 0.1.0

### Summary
Initial release covering all the 15 modules.

