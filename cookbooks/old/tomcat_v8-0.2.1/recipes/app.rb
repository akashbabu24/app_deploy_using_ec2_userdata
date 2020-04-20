#
# Cookbook:: tomcat_v8
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

tomcat_install_dir=node['tomcat']['tomcat_install_dir']
tomcat_user=node['tomcat']['tomcat_user']
app_name=node['app']['name']
webapps_path=node['tomcat']['deployment_path']
tomcat_group=node['tomcat']['tomcat_group']

bash 'tomcat deployment' do
  user "#{tomcat_user}"
  group "#{tomcat_group}"
  code <<-EOH
	curl #{node['app']['artifact_url']} -o /tmp/#{app_name}
	mv /tmp/#{app_name} #{webapps_path}
  EOH
end

script "Retart the tomcat instance" do
        interpreter "bash"
        user "#{tomcat_user}"
	group "#{tomcat_group}"
        cwd "/tmp"
        code <<-EOH
                #{tomcat_install_dir}/apache-tomcat/bin/catalina.sh stop
		#{tomcat_install_dir}/apache-tomcat/bin/catalina.sh start
        EOH
end
