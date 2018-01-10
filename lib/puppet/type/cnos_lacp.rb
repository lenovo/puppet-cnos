#
# Copyright (C) 2017 Lenovo, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#       http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

Puppet::Type.newtype(:cnos_lacp) do
  desc ' = {
 	    Manage Lacp on Lenovo cnos.

 	    Example:
 	     cnos_lacp {"lacp":
		      sys_prio => <sys_prio>
              }
           }'

  # Parameters
  newparam(:title, namevar: true) do
    desc 'name of parameter'
  end

  # Properties
  newproperty(:sys_prio) do
    desc 'integer from 1-65535'

    munge(&:to_i)

    validate do |value|
      unless value.to_i.between?(1, 65535)
        raise 'value not within limit (1-65535)'
      end
    end
  end
end
