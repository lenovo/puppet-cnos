require 'spec_helper'

describe 'cnos_vlag_conf', type: :type do
  let(:type_class) { Puppet::Type.type(:cnos_vlag_conf) }

  let :params do
    [
      :title
    ]
  end

  let :properties do
    %i[
      status
      tier_id
      priority
      auto_recover
      startup_delay
    ]
  end

  it 'should have expected properties' do
    properties.each do |property|
      expect(type_class.properties.map(&:name)).to be_include(property)
    end
  end

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
    type_class.new(name: 'VLAG Configuration',
                   title: 'vlag_conf', ensure: :present)
  end
end
