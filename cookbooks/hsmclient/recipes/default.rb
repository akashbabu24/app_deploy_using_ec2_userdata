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

execute "Copy customerCA.crt" do
  command "cp -r /home/ec2-user/customerCA.crt  /opt/cloudhsm/etc/customerCA.crt"
end

execute "Update configuration files for CloudHSM Client" do
  command "sudo /opt/cloudhsm/bin/configure -a #{node['ipaddress_one']}"
end

