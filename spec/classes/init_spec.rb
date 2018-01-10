require 'spec_helper'
describe 'cnos' do
  context 'with default values for all parameters' do
    it { should contain_class('cnos') }
  end
end
