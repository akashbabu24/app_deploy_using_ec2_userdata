# This is an optional recipe that provides monit monitoring of your riak node. Requires the monit cookbook.

include_recipe "monit::default"

monitrc "haproxy" do
  variables(
    :stats_url => node['haproxy']['monit']['stats_url']
  )
  template_source "haproxy-monit.conf.erb"
  template_cookbook "haproxy"
end
