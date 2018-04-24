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

require 'puppet/util/network_device/base'
require File.join(File.dirname(__FILE__), '../cnos')
require File.join(File.dirname(__FILE__), '../cnos/facts')
require File.join(File.dirname(__FILE__), '../transport/cnos')

require 'uri'

# This is a utilty class
class Puppet::Util::NetworkDevice::Cnos::Device
  attr_reader :connection
  attr_accessor :url, :transport

  def initialize(url, options = {})
    @url = URI.parse(url)

    @autoloader = Puppet::Util::Autoload.new(
      self,
      'puppet/util/network_device/transport',
    )
    @transport = Puppet::Util::NetworkDevice::Transport::Cnos.new(url, options[:debug]) if @autoloader.load('cnos')
  end

  def facts
    Puppet.debug(self.class.to_s.split('::').last + ': Inside Device FACTS Initialize')
    @facts ||= Puppet::Util::NetworkDevice::Cnos::Facts.new(@transport)

    @facts.retrieve
  end
end
