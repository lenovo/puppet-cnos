class Puppet::Util::NetworkDevice::Cnos::Facts
  attr_reader :transport

  def initialize(transport)
    Puppet.debug(self.class.to_s.split('::').last + ': Inside Initialize of Facts!')
    @transport = transport
  end

  def retrieve
    Puppet.debug(self.class.to_s.split('::').last + ': Retrieving Facts from facts.rb!')
    facts = {}
    facts.merge(parse_device_facts)
    # facts = parse_device_facts()
  end

  def parse_device_facts
    facts = {
      operatingsystem: :cnos
    }
    # if response = @transport.call('/nos/api/system/')
    if response = @transport.call('/nos/api/sysinfo/inventory')
      # result = items.first
      Puppet.debug("response  = #{response}")
      result = response
    else
      Puppet.warning('Did not receive device details. CNOS REST requires Administrator level access.')
      return facts
    end

    # [ :switch_type,
    #  :fw_version
    # ].each do |fact|
    [:Name,
     :Description,
     :Model,
     :'Manufacture Date',
     :'Serial Number',
     :'Part Number',
     :'Software Revision',
     :'Electronic Serial Number',
     :'Mgmt mac',
     :'Machine Type Model',
     :UpTime].each do |fact|
      # Puppet.debug("response  = #{result[fact.to_s]}")
      facts[fact] = result[fact.to_s]
    end

    # Map CNOS names to expected standard names.
    # facts[:switch_type]            = facts[:switch_type]
    # facts[:fw_version]             = facts[:fw_version]
    facts[:Name]                       = facts[:Name]
    facts[:Description]                = facts[:Description]
    facts[:Model]                      = facts[:Model]
    facts[:'Manufacture Date']         = facts[:'Manufacture Date']
    facts[:'Serial Number']            = facts[:'Serial Number']
    facts[:'Part Number']              = facts[:'Part Number']
    facts[:'Software Revision']        = facts[:'Software Revision']
    facts[:'Serial Number']            = facts[:'Serial Number']
    facts[:'Electronic Serial Number'] = facts[:'Electronic Serial Number']
    facts[:'Mgmt mac']                 = facts[:'Mgmt mac']
    facts[:'Machine Type Model']       = facts[:'Machine Type Model']
    facts[:UpTime] = facts[:UpTime]

    facts.each do |key, value|
      Puppet.notice("Key  = #{key} , Value = #{value}")
    end

    facts
  end
end
