require 'spec_helper'

describe 'cnos_vlag_hc', type: :type do
  let(:type_class) { Puppet::Type.type(:cnos_vlag_hc) }

  let :params do
    [
      :name,
    ]
  end

  let :properties do
    [
      :peer_ip,
      :vrf,
      :keepalive_attempts,
      :keepalive_interval,
      :retry_interval,
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
    type_class.new(name: 'VLAG Health Check', title: 'vlag', ensure: :present)
  end
end
