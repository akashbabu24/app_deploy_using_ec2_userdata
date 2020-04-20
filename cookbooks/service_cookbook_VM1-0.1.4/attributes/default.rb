#
# Cookbook Name:: tomcat_latest
# Attributes:: default
#
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

default['tomcat']['tomcat_folder']='/opt/apache/apache-tomcat/'
default['tomcat']['deployment_path']="#{node['tomcat']['tomcat_folder']}/webapps/"

default['tomcat_v8']['tomcat_url']="http://archive.apache.org/dist/tomcat/tomcat-8/"
default['tomcat_v8']['tomcat_version']="8.5.15"
default['tomcat_v8']['tomcat_install_dir']="/opt/apache"
default['tomcat_v8']['tomcat_user']="tomcat"
default['tomcat_v8']['tomcat_auto_start']="true"

#default['app']['artifact_url']="nexus_url"
default['app']['name']="artifact_file_name"

default['tomcat']['tomcat_group'] = 'tomcat'
default['tomcat']['tomcat_manage_dir'] = "#{node['tomcat']['tomcat_folder']}/webapps/manager/META-INF"
default['tomcat']['tomcat_conf_dir'] = "#{node['tomcat']['tomcat_folder']}/conf"
