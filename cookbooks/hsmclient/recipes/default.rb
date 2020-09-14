#
# Cookbook:: hsmclient
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

package "wget" do
  action :install
end

execute "hsm-client installation" do
  command "wget https://s3.amazonaws.com/cloudhsmv2-software/CloudHsmClient/EL7/cloudhsm-client-latest.el7.x86_64.rpm  && sudo yum install -y ./cloudhsm-client-latest.el7.x86_64.rpm"
  action :run
end

package "python3" do
  action :install
end

link '/usr/bin/python' do
  to '/usr/bin/python3'
end

template "/opt/cloudhsm/etc/customerCA.crt" do
   source "customerCA.crt.erb"
   owner "root"
   group "root"
   mode 0644
end

execute "Update configuration files for CloudHSM Client" do
  command "sudo /opt/cloudhsm/bin/configure -a #{node['ipaddress_one']}"
end

