require 'spec_helper'

describe 'cnos_vlag_conf', type: :type do
  let(:type_class) { Puppet::Type.type(:cnos_vlag_conf) }

  let :params do
    [
      :name,
    ]
  end

  let :properties do
    [
      :status,
      :tier_id,
      :priority,
      :auto_recover,
      :startup_delay,
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

  it 'does require a name' do
    expect do
      type_class.new({})
    end.to raise_error(Puppet::Error, 'Title or name must be provided')
  end

  it 'does support :present as a value to :ensure' do
    type_class.new(name: 'VLAG Configuration',
                   title: 'vlag_conf', ensure: :present)
  end
end
