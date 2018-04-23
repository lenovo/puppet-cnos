require 'spec_helper'

describe 'cnos_ip_intf', type: :type do
  let(:type_class) { Puppet::Type.type(:cnos_ip_intf) }

  let :params do
    [
      :name,
    ]
  end

  let :properties do
    [
      :if_name,
      :vrf_name,
      :bridge_port,
      :mtu,
      :ip_addr,
      :ip_prefix_len,
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

  # it 'does require a name' do
  #   expect do
  #     type_class.new({})
  #   end.to raise_error(Puppet::Error, 'Title or name must be provided')
  # end

  it 'does require a name' do
    expect { type_class.new({}) }.to raise_error(Puppet::Error, 'Title or name must be provided')
  end

  it 'does support :present as a value to :ensure' do
    type_class.new(name: 'Interface IP Mapping is ',
                   if_name: 'Ethernet1/11', ensure: :present)
  end
end
