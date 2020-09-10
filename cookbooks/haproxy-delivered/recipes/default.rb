#
# Cookbook Name:: haproxy
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "haproxy::install_from_package"

directory "/etc/firewalld/services" do
  owner "root"
  group "root"
  mode '0755'
  recursive true
  action :create
end

template "/etc/firewalld/services/haproxy-http.xml" do
  source "haproxy-http.xml.erb"
  owner "root"
  group "root"
  mode 0640
end

template "/etc/firewalld/services/haproxy-https.xml" do
  source "haproxy-https.xml.erb"
  owner "root"
  group "root"
  mode 0640
end

script "Selinux configuration" do
        interpreter "bash"
        user "root"
        code <<-EOH
                restorecon /etc/firewalld/services/haproxy-https.xml
		restorecon /etc/firewalld/services/haproxy-http.xml
        EOH
end

template "/etc/haproxy/haproxy.pem" do
  source "haproxy.pem.erb"
  owner "root"
  group "root"
  mode 0644
end

service "haproxy" do
  supports :restart => true, :status => true, :reload => true
  action [:enable, :start]
end

template "/etc/haproxy/haproxy.cfg" do
  source "haproxy_ssl.cfg.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[haproxy]"
end
