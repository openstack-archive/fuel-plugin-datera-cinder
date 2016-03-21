require 'spec_helper'

describe 'cinder::volume::datera' do
  let :req_params do
    {
      :san_ip       => '192.168.1.81',
      :san_login    => 'openstack_tenant0',
      :san_password => 'password',
      :datera_num_replicas => '2',
    }
  end

  let :params do
    req_params
  end

  describe 'datera volume driver' do
    it 'configure datera volume driver' do
      is_expected.to contain_cinder_config('DEFAULT/volume_driver').with_value('cinder.volume.drivers.datera.DateraDriver')
      is_expected.to contain_cinder_config('DEFAULT/san_ip').with_value('192.168.1.81')
      is_expected.to contain_cinder_config('DEFAULT/san_login').with_value('openstack_tenant0')
      is_expected.to contain_cinder_config('DEFAULT/san_password').with_value('password')
      is_expected.to contain_cinder_config('DEFAULT/datera_num_replicas').with_value('2')
    end

    it 'marks san_password as secret' do
      is_expected.to contain_cinder_config('DEFAULT/san_password').with_secret( true )
    end

  end

  describe 'datera volume driver with additional configuration' do
    before :each do
      params.merge!({:extra_options => {'datera_backend/param1' => {'value' => 'value1'}}})
    end

    it 'configure datera volume with additional configuration' do
      should contain_cinder__backend__datera('DEFAULT').with({
        :extra_options => {'datera_backend/param1' => {'value' => 'value1'}}
      })
    end
  end

end
