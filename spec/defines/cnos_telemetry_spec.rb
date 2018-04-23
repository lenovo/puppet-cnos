require 'spec_helper'

describe 'cnos_telemetry', type: :type do
  let(:type_class) { Puppet::Type.type(:cnos_telemetry) }

  let :params do
    [
      :bst_feature,
    ]
  end

  let :properties do
    [
      :bst_enable,
      :send_async_reports,
      :async_full_report,
      :collection_interval,
      :trigger_rate_limit,
      :trigger_rate_limit_interval,
      :send_snapshot_on_trigger,
      :async_full_reports,
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
    type_class.new(name: 'BST Features are ',
                   bst_feature: 'bst_feature', ensure: :present)
  end
end
