#
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

require 'puppet/util/network_device'
require 'puppet/util/network_device/transport'
require 'puppet/util/network_device/transport/base'

# This is a transport utility class
class Puppet::Util::NetworkDevice::Transport::Cnos < Puppet::Util::NetworkDevice::Transport::Base
  attr_reader :connection

  def initialize(url, _options = {})
    Puppet.debug("url = #{url}")

    require 'cnos-rbapi'
    # array = url.split(/:/)
    array = url.split(%r{:})
    transport = array[0]
    username = array[1]
    username = username[2, username.length]
    # innerarray = array[2].split(/@/)
    innerarray = array[2].split(%r{@})
    password = innerarray[0]
    switch_ip = innerarray[1]
    switch_ip = switch_ip[0, switch_ip.length - 1] if switch_ip.chars.last == '/'
    portnumber = '443'
    unless array [3].nil?
      portnumber = array [3]
      if portnumber.chars.last == '/'
        portnumber = portnumber[0, portnumber.length - 1]
      end
    end
    params = {}
    params['transport'] = transport
    params['port'] = portnumber
    params['ip'] = switch_ip
    params['user'] = username
    params['password'] = password
    @connection = Connect.new(params)
  end

  def call(url, args = {})
    begin
      Puppet.debug("connection = #{@connection.inspect}")
      result = @connection.getFacts(url, args)
      Puppet.debug("result  = #{result}")
      response = JSON.parse(result)
      Puppet.debug("response  = #{response}")
      Puppet.debug("result = #{result.inspect}")
      return response
    rescue StandardError => e
      Puppet.debug("Error Message = #{e.message}")
      Puppet.debug("Backtrace = #{e.backtrace.inspect}")
    end
  rescue JSON::ParserError
  end

  def failure?(result)
    raise("REST failure: HTTP status code #{result.status} detected.  Body of failure is: #{result.body}") unless result.status == 200
  end

  def post(url, json)
    if valid_json?(json)
      result = connection.post do |req|
        req.url url
        req.headers['Content-Type'] = 'application/json'
        req.body = json
      end
      failure?(result)
      result
    else
      raise('Invalid JSON detected.')
    end
  end

  def put(url, json)
    if valid_json?(json)
      result = connection.put do |req|
        req.url url
        req.headers['Content-Type'] = 'application/json'
        req.body = json
      end
      failure?(result)
      result
    else
      raise('Invalid JSON detected.')
    end
  end

  def delete(url)
    result = connection.delete(url)
    failure?(result)
    result
  end

  def valid_json?(json)
    JSON.parse(json)
    true
  rescue JSON::ParserError
    false
  end
end
