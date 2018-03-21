require 'spec_helper'

describe 'cnos_sys', type: :type do
  let(:type_class) { Puppet::Type.type(:cnos_sys) }

  let :params do
    [
      :sys_feature
    ]
  end

  let :properties do
    %i[
      heartbeat_enable
      msg_interval
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
    type_class.new(name: 'Telemetry System Configuration',
                   sys_feature: 'sys', ensure: :present)
  end
end
