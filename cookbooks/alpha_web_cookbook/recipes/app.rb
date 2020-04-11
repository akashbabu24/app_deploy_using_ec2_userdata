#
# Cookbook:: tomcat_v8
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

tomcat_install_dir=node['tomcat_v8']['tomcat_install_dir']
tomcat_user=node['tomcat_v8']['tomcat_user']
app_name=node['app']['name']
webapps_path=node['tomcat']['deployment_path']

bash 'tomcat deployment' do
  user "#{tomcat_user}"
  code <<-EOH
	echo ${alphawebartifacturl}
	mkdir #{node['tomcat']['deployment_path']}/angular
	curl ${alphawebartifacturl} -o /tmp/#{app_name}
        cd /tmp
        tar -xf #{app_name}
	mv dist/FormSubmit/* #{node['tomcat']['deployment_path']}/angular/
  EOH
end

#script "Retart the tomcat instance" do
 #       interpreter "bash"
  #      user "#{tomcat_user}"
   #     cwd "/tmp"
    #    code <<-EOH
     #           #{tomcat_install_dir}/apache-tomcat/bin/catalina.sh stop
#		#{tomcat_install_dir}/apache-tomcat/bin/catalina.sh start
 #       EOH
#end
