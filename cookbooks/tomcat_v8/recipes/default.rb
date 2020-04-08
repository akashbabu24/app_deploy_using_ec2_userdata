#
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

tomcat_url=node['tomcat']['tomcat_url']
tomcat_version=node['tomcat']['tomcat_version']
tomcat_install_dir=node['tomcat']['tomcat_install_dir']
tomcat_user=node['tomcat']['tomcat_user']
tomcat_auto_start=node['tomcat']['tomcat_auto_start']
tomcat_group=node['tomcat']['tomcat_group']

group "#{node['tomcat']['tomcat_group']}"

user "tomcat" do
        group "#{node['tomcat']['tomcat_group']}"
        system true
        shell "/bin/bash"
end

directory "#{tomcat_install_dir}" do
  owner "#{tomcat_user}"
  group "#{node['tomcat']['tomcat_group']}"
  mode '0755'
  recursive true
  action :create
end


## Include the dependencies
include_recipe "java_se"


## Download the tomcat package
download_url="#{tomcat_url}"+"v#{tomcat_version}"+"/bin/apache-tomcat-#{tomcat_version}.tar.gz"

script "Download Apache Tomcat version #{tomcat_version}" do
        interpreter "bash"
        user "#{tomcat_user}"
	group "#{tomcat_group}"
        cwd "/tmp"
        code <<-EOH
                curl "#{download_url}" -o "/tmp/apache-tomcat-#{tomcat_version}.tar.gz"
                #mkdir -p #{tomcat_install_dir}
        EOH
end


## Extract the package

script "Extracting the Apache Tomcat Package" do
        interpreter "bash"
        user "#{tomcat_user}"
        group "#{tomcat_group}"
	cwd "/tmp"
        code <<-EOH
                tar -zxvf /tmp/apache-tomcat-#{tomcat_version}.tar.gz -C #{tomcat_install_dir}
        EOH
end


## Move the unzipped package to /opt/apache/tomcat/apache-tomcat

script "Move the package" do
        interpreter "bash"
        user "#{tomcat_user}"
	group "#{tomcat_group}"
        cwd "/tmp"
        code <<-EOH
                if [[ ! -d /opt/apache/tomcat/apache-tomcat  ]] ; then
                        cd #{tomcat_install_dir} ; mv apache-tomcat-* apache-tomcat
                else
                        echo "Directory already exists"
                fi
        EOH
end

cookbook_file "#{node['tomcat']['tomcat_manage_dir']}/context.xml" do
        source "context.xml"
        action :create
        user "#{node['tomcat']['tomcat_user']}"
        group "#{node['tomcat']['tomcat_group']}"
        mode 00640
        only_if {Dir.exists?("#{node['tomcat']['tomcat_manage_dir']}") || Dir.exists?('/opt/tomcat')}
end
cookbook_file "#{node['tomcat']['tomcat_conf_dir']}/tomcat-users.xml" do
        source "tomcat-users.xml"
        action :create
        user "#{node['tomcat']['tomcat_user']}"
        group "#{node['tomcat']['tomcat_group']}"
        mode 00600
        only_if {Dir.exists?("#{node['tomcat']['tomcat_conf_dir']}") || Dir.exists?('/opt/tomcat')}
end

cookbook_file "#{node['tomcat']['tomcat_conf_dir']}/server.xml" do
        source "server.xml"
        action :create
        user "#{node['tomcat']['tomcat_user']}"
        group "#{node['tomcat']['tomcat_group']}"
        mode 00600
        only_if {Dir.exists?("#{node['tomcat']['tomcat_conf_dir']}") || Dir.exists?('/opt/tomcat')}
end

## Start the tomcat instance


script "Start the tomcat instance" do
        interpreter "bash"
        user "#{tomcat_user}"
	group "#{tomcat_group}"
        cwd "/tmp"
        code <<-EOH
                #{tomcat_install_dir}/apache-tomcat/bin/startup.sh
        EOH
end

include_recipe 'tomcat_v8::app'
