require 'spec_helper'

describe 'cnos_arp', type: :type do
  let(:type_class) { Puppet::Type.type(:cnos_arp) }

  let :params do
    [
      :name,
    ]
  end

  let :properties do
    [
      :ageout_time,
    ]
  end

  it {
    is_expected.to be_valid_type.with_properties do
      expect(type_class.properties.map(&:name)).to be_include(property)
    end
  }

  it 'should have expected parameters' do
    params.each do |param|
      expect(type_class.parameters).to be_include(param)
    end
  end

  it 'should require a name' do
    expect do
      type_class.new({})
    end.to raise_error(Puppet::Error, 'Title or name must be provided')
  end

  it 'should support :present as a value to :ensure' do
    type_class.new(name: 'ARP Configuration for ',
                   if_name: 'Ethernet1/1', ensure: :present)
  end
end
