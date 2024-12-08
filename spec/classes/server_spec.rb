require 'spec_helper'

describe 'olnfs::server' do
    let(:facts) { {:operatingsystem => 'ubuntu', :concat_basedir => '/tmp', } }
    it do
      should contain_concat__fragment('olnfs_exports_header').with( 'target' => '/etc/exports' )
    end
    context "olnfs_v4 => true" do
      let(:params) { {:olnfs_v4 => true, } }
      it do
        should contain_concat__fragment('olnfs_exports_root').with( 'target' => '/etc/exports' )
        should contain_file('/export').with( 'ensure' => 'directory' )
      end
    end

  context "operatingsysten => ubuntu" do
    let(:facts) { {:operatingsystem => 'ubuntu', :concat_basedir => '/tmp', } }
    it { should contain_class('olnfs::server::ubuntu') }
  end

  context "operatingsysten => ubuntu with params for mountd" do
    let(:facts) { {:operatingsystem => 'ubuntu', :concat_basedir => '/tmp', } }
    let(:params) {{ :mountd_port => '4711', :mountd_threads => '99' }}

    it do
     should contain_class('olnfs::server::ubuntu').with( 'mountd_port' => '4711', 'mountd_threads' => '99' )
    end
  end

  context "operatingsysten => debian" do
    let(:facts) { {:operatingsystem => 'debian', :concat_basedir => '/tmp',} }
    it { should contain_class('olnfs::server::debian') }
  end

  context "operatingsysten => scientific" do
    let(:facts) { {:operatingsystem => 'scientific', :concat_basedir => '/tmp', :operatingsystemrelease => '6.4' } }
    it { should contain_class('olnfs::server::redhat') }
  end
  context "operatingsysten => SLC" do
    let(:facts) { {:operatingsystem => 'SLC', :concat_basedir => '/tmp', :operatingsystemrelease => '6.4' } }
    it { should contain_class('olnfs::server::redhat') }
  end

  context "operatingsysten => centos v6" do
    let(:facts) { {:operatingsystem => 'centos', :concat_basedir => '/tmp', :operatingsystemrelease => '6.4' } }
    it { should contain_class('olnfs::server::redhat') }
  end
  context "operatingsysten => redhat v6" do
    let(:facts) { {:operatingsystem => 'redhat', :concat_basedir => '/tmp', :operatingsystemrelease => '6.4' } }
    it { should contain_class('olnfs::server::redhat') }
  end
  context "operatingsysten => Amazon v3" do
    let(:facts) { {:operatingsystem => 'Amazon', :concat_basedir => '/tmp', :operatingsystemrelease => '3.10.35-43.137.amzn1.x86_64' } }
    it { should contain_class('olnfs::server::redhat') }
  end
  context "operatingsysten => Amazon v3" do
    let(:facts) { {:operatingsystem => 'Amazon', :concat_basedir => '/tmp', :operatingsystemrelease => '4.1.7-15.23.amzn1.x86_64' } }
    it { should contain_class('olnfs::server::redhat') }
  end
  context "operatingsysten => gentoo" do
    let(:facts) { {:operatingsystem => 'gentoo', :concat_basedir => '/tmp',} }
    it { should contain_class('olnfs::server::gentoo') }
  end
  context "operatingsysten => darwin" do
    let(:facts) { {:operatingsystem => 'darwin'} }
    it do
      expect {
        should contain_class('olnfs::server::darwin')
      }.to raise_error(Puppet::Error, /olnfs server is not supported on Darwin/)
    end
  end
end
