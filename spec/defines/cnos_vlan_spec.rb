require 'spec_helper'

describe 'cnos_vlan', type: :type do
  let(:type_class) { Puppet::Type.type(:cnos_vlan) }

  let :params do
    [
      :name,
    ]
  end

  let :properties do
    [
      :vlan_id,
      :vlan_name,
      :admin_state,
    ]
  end

  # it {
  #   is_expected.to be_valid_type.with_properties do
  #     expect(type_class.properties.map(&:name)).to be_include(property)
  #   end
  # }

  it 'does have expected properties' do
    properties.each do |property|
      expect(type_class.properties.map(&:name)).to be_include(property)
    end
  end

  it 'does have expected parameters' do
    params.each do |param|
      expect(type_class.parameters).to be_include(param)
    end
  end

  it 'does require a name' do
    expect do
      type_class.new({})
    end.to raise_error(Puppet::Error, 'Title or name must be provided')
  end

  it 'does support :present as a value to :ensure' do
    type_class.new(name: 'A great VLAN', vlan_id: '20', ensure: :present)
  end
end
