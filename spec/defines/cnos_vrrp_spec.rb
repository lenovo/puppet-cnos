require 'spec_helper'

describe 'cnos_vrrp', type: :type do
  let(:type_class) { Puppet::Type.type(:cnos_vrrp) }

  let :params do
    [
      :vr_id
    ]
  end

  let :properties do
    %i[
      if_name
      ip_addr
      ad_intvl
      preempt
      prio
      admin_state
      track_if
      accept_mode
      v2_compt
      switch_back_delay
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
    type_class.new(name: 'VRRP Configuration has', vr_id: '1', ensure: :present)
  end
end
