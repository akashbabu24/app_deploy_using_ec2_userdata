package "unzip" do
  action :install
end

script "Download agent zip from s3" do
        interpreter "bash"
        cwd "/tmp"
        code <<-EOH
                /usr/local/bin/aws s3 cp #{node['AppDynamics']['machine_agent_source_url']} /tmp/machineagent.zip
        EOH
end

execute 'mkdir machineagent dir' do
  command 'mkdir /opt/machineagent'
  not_if { File.exists?("/opt/machineagent/machineagent.jar") }
end

execute 'extract_zip' do
  command 'unzip /tmp/machineagent.zip -d /opt/machineagent'
  cwd '/opt/machineagent'
  not_if { File.exists?("/opt/machineagent/machineagent.jar") }
end


#archive_file '#{node['AppDynamics']['machine_agent_source_file']}' do
 # source node['AppDynamics']['machine_agent_source_dir']
  #path node['AppDynamics']['machine_agent_install_dir']
#end

template "/opt/machineagent/conf/controller-info.xml" do
  source "controller-info.xml.erb"
  owner "root"
  group "root"
  mode 0755
end

template "/opt/machineagent/monitors/analytics-agent/conf/analytics-agent.properties" do
  source "analytics-agent.properties.erb"
  owner "root"
  group "root"
  mode 0755
end

execute "machine-agent" do
  command "/opt/machineagent/bin/machine-agent -d -p /opt/machineagent/pidfile"
end
