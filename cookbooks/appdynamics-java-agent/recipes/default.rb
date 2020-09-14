package "unzip" do
  action :install
end

script "Download agent zip from s3" do
        interpreter "bash"
        cwd "/tmp"
        code <<-EOH
                /usr/local/bin/aws s3 cp #{node['AppDynamics']['java_agent_source_url']} /tmp/appagent.zip
        EOH
end


execute 'make dir /opt/appagent' do
  command 'mkdir /opt/appagent'
  not_if { File.exists?("/opt/appagent/javaagent.jar") }
end

execute 'extract_zip' do
  command 'unzip /tmp/appagent.zip -d /opt/appagent'
  cwd '/opt/appagent'
  not_if { File.exists?("/opt/appagent/javaagent.jar") }
end

template "/opt/appagent/conf/controller-info.xml" do
  source "controller-info.xml.erb"
  owner "root"
  group "root"
  mode 0755
end


template "/opt/apache/apache-tomcat/bin/catalina.sh" do
  source "catalina.sh.erb"
  owner "root"
  group "root"
  mode 0755
end

# command unzip AppServerAgent-20.8.0.30686.zip -d /opt/appdynamics/appagent
#archive_file 'AppServerAgent-20.8.0.30686.zip' do
 # path '/tmp/AppServerAgent-20.8.0.30686.zip'
  #destination '/opt/appdynamics/appagent'
  #owner 'root'
  #group 'root'
  #mode '755'
#end

#file '/opt/appagent/conf/controller.info.xml' do
 # action :create_if_mission
  #content <<~controllerinfo
    #!/bin/bash -x
   # host_name=''
    #port=''
    #app_name=''
    #tier_name=''
   # node_name=''
    #updating host entries
   # sudo sed -i "s/\<controler-host>${host_name}"
    #sudo sed -i "s/\<controler-port>${port}"
    #sudo sed -i "s/\<application-name>${app_name}"
    #sudo sed -i "s/\<tier-name>${tier_name}"
    #sudo sed -i "s/\<node-name>${node_name}"
  #mode '00600'
  #owner 'root'
  #group 'root'
#end



#file '/opt/apache-tomcat-8.5.31/bin/catalina.sh' do
 # action :update
 # content <<~catalina.sh
 # export CATALINA_OPTS="CATALINA_OPTS -javaagent:/opt/appagent/javaagent.jar"
 # mode '0777'
#end

execute 'shutdown-tomcat' do
  command '/opt/apache/apache-tomcat/bin/shutdown.sh'
  action :run
end

execute 'start-tomcat' do
  command '/opt/apache/apache-tomcat/bin/startup.sh'
  action :run
end
