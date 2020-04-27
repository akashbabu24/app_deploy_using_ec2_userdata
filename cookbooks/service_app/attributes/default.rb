#
# Cookbook Name:: service_app
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

default['tomcat_v8']['tomcat_install_dir']="/opt/apache"
default['tomcat_v8']['tomcat_user']="tomcat"

#default['app']['artifact_url']="nexus_url"
default['app']['name']="artifact_file_name"

default['tomcat']['tomcat_group'] = 'tomcat'