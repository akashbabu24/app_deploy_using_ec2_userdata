#
# Cookbook:: tomcat_v8
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

#tomcat_install_dir=node['tomcat_v8']['tomcat_install_dir']
tomcat_user=node['tomcat_v8']['tomcat_user']
#app_name=node['app']['name']
webapps_path=node['tomcat']['deployment_path']

bash 'tomcat deployment' do
  user "#{tomcat_user}"
  code <<-EOH
        arraylength=${#alphaserviceartifacturl[@]}
	for (( i=0; i<${arraylength}; i++ ))
	 do
	 curl ${alphaserviceartifacturl[$i]} -o /tmp/${alphaserviceartifactfile[$i]}
	 mv /tmp/${alphaserviceartifactfile[$i]} #{webapps_path}
	done	
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
