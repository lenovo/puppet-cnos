require 'puppet/util/network_device'
require 'puppet/util/network_device/transport'
require 'puppet/util/network_device/transport/base'

class Puppet::Util::NetworkDevice::Transport::Cnos < Puppet::Util::NetworkDevice::Transport::Base
  attr_reader :connection

  def initialize(url, _options = {})
    Puppet.debug("url = #{url}")
    # require 'faraday'

    # @connection = Faraday.new(url: url, ssl: { verify: false })
    # @connection.basic_auth("admin", "admin")
    require 'cnos-rbapi'
    array = url.split(/:/)
    transport = array[0]
    username = array[1]
    username = username[2, username.length]
    innerarray = array[2].split(/@/)
    password = innerarray[0]
    switchIP = innerarray[1]
    switchIP = switchIP[0, switchIP.length - 1] if switchIP.chars.last == '/'
    portnumber = '443'
    if array [3] != nil
      portnumber = array [3]
      if portnumber.chars.last == '/'
        portnumber = portnumber[0, portnumber.length - 1]
      end
    end
    params = {}
    params['transport'] = transport
    params['port'] = portnumber
    params['ip'] = switchIP
    params['user'] = username
    params['password'] = password
    # params = {"transport" => "https", "port" => 443, "ip" => "10.241.107.39", "user" => "admin", "password" => "admin"}
    # @connection = Connect.new(params: params, ssl:{ verify: false })
    @connection = Connect.new(params)
  end

  def call(url, args = {})
    # Puppet.debug("connection = #{connection.inspect}")
    # result = connection.get(url, args)
    # JSON.parse(result.body)
    # Puppet.debug("result = #{result.inspect}")
    begin
      Puppet.debug("connection = #{@connection.inspect}")
      result = @connection.getFacts(url, args)
      Puppet.debug("result  = #{result}")
      # JSON.parse(result.body)
      response = JSON.parse(result)
      Puppet.debug("response  = #{response}")
      Puppet.debug("result = #{result.inspect}")
      return response
    rescue Exception => e
      Puppet.debug("Error Message = #{e.message}")
      Puppet.debug("Backtrace = #{e.backtrace.inspect}")
    end
  rescue JSON::ParserError
    # This should be better at handling errors
    return nil
  end

  def failure?(result)
    unless result.status == 200
      raise("REST failure: HTTP status code #{result.status} detected.  Body of failure is: #{result.body}")
    end
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
    return true
  rescue
    return false
  end

  # Given a string containing objects matching /Partition/Object, return an
  # array of all found objects.
  def find_monitors(string)
    return nil if string.nil?
    if string == 'default'
      ['default']
    elsif string =~ %r{/none$}
      ['none']
    else
      string.scan(/(\/\S+)/).flatten
    end
  end

  # Monitoring:  Parse out the availability integer.
  def find_availability(string)
    return nil if string.nil?
    return nil if string == 'default' || string == 'none'
    # Look for integers within the string.
    matches = string.match(/min\s(\d+)/)
    if matches
      matches[1]
    else
      'all'
    end
  end
end
