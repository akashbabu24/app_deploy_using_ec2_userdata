#
# Cookbook:: tomcat_v8
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

tomcat_install_dir=node['tomcat']['tomcat_install_dir']
tomcat_user=node['tomcat']['tomcat_user']
#app_name=node['app']['name']
webapps_path=node['tomcat']['deployment_path']
tomcat_group=node['tomcat']['tomcat_group']

nexus_url=node['app']['nexus_url']
repository_name=node['app']['repository_name']
app_groupd_id=node['app']['app_groupd_id']
app_artifact_id=node['app']['app_artifact_id']
app_version=node['app']['app_version']
app_extension=node['app']['app_extension']

bash 'tomcat deployment' do
  user "#{tomcat_user}"
  group "#{tomcat_group}"
  code <<-EOH
	#curl #{node['app']['artifact_url']} -o /tmp/#{app_name}
	#mv /tmp/#{app_name} #{webapps_path}
  	curl -X GET '"#{nexus_url}"/service/rest/v1/search/assets?repository="#{repository_name}"&group="#{app_groupd_id}"&name="#{app_artifact_id}"&version="#{app_version}"&maven.extension="#{app_extension}"&maven.classifier' \
	| grep -Po '"downloadUrl" : "\K.+(?=",)' \
 	| xargs curl -fsSL -o /tmp/"#{app_artifact_id}"."#{app_extension}"
cp /tmp/"#{app_artifact_id}"."#{app_extension}" #{webapps_path}
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
