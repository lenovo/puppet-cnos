require 'spec_helper'

describe sample do
  describe package('httpd'), if: os[:family] == 'redhat' do
    it { is_expected.to be_installed }
  end

  describe package('apache2'), if: os[:family] == 'ubuntu' do
    it { is_expected.to be_installed }
  end

  describe service('httpd'), if: os[:family] == 'redhat' do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end

  describe service('apache2'), if: os[:family] == 'ubuntu' do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end

  describe service('org.apache.httpd'), if: os[:family] == 'darwin' do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end

  describe port(80) do
    it { is_expected.to be_listening }
  end
end
