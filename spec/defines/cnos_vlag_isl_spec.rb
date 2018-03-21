require 'spec_helper'

describe 'cnos_vlag_isl', type: :type do
  let(:type_class) { Puppet::Type.type(:cnos_vlag_isl) }

  let :params do
    [
      :title
    ]
  end

  let :properties do
    %i[
      port_aggregator
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
    type_class.new(name: 'VLAG ISL Configuration',
                   title: 'vlag_isl', ensure: :present)
  end
end
