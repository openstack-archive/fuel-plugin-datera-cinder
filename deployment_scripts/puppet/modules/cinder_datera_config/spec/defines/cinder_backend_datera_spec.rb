require 'spec_helper'

describe 'cinder::backend::datera' do
  let (:title) { 'datera' }

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
      is_expected.to contain_cinder_config('datera/volume_driver').with_value(
        'cinder.volume.drivers.datera.DateraDriver')
      is_expected.to contain_cinder_config('datera/san_ip').with_value(
        '192.168.1.81')
      is_expected.to contain_cinder_config('datera/san_login').with_value(
        'openstack_tenant0')
      is_expected.to contain_cinder_config('datera/san_password').with_value(
        'password')
      is_expected.to contain_cinder_config('datera/datera_num_replicas').with_value(
        '2')
    end
  end

  describe 'datera backend with additional configuration' do
    before :each do
      params.merge!({:extra_options => {'datera/param1' => {'value' => 'value1'}}})
    end

    it 'configure datera backend with additional configuration' do
      should contain_cinder_config('datera/param1').with({
        :value => 'value1',
      })
    end
  end

end
