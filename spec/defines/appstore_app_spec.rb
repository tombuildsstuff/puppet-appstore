require 'spec_helper'

describe 'appstore::app' do

  let(:facts) { default_test_facts }
  let(:title) { 'Twitter' }

  context 'without source' do
    it do
      expect {
        should contain_class 'appstore'
      }.to raise_error Puppet::Error, /Must pass/
    end
  end

  context 'with source' do
    let(:params) do
      { :source => 'twitter/id409789998' }
    end

    it do
      should contain_class 'appstore'

      should contain_exec('appstore-app-Twitter').with({
        :command => "open -W '/opt/boxen/appstore.app' && [ -d '/Applications/Twitter.app' ]",
        :creates => '/Applications/Twitter.app',
        :timeout => 0,
        :environment => [
          'BOXEN_APPSTORE_SOURCE=macappstore://itunes.apple.com/us/app/twitter/id409789998',
          'BOXEN_APPSTORE_ID=appleid@me.com',
          'BOXEN_APPSTORE_PASSWORD=jlaw4life',
        ]
      })
    end
  end
end
