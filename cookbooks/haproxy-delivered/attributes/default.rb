#
# Cookbook Name:: haproxy
# Default:: default
#
# Copyright 2010, Opscode, Inc.
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
#

default['haproxy']['incoming_port'] = "80"
default['haproxy']['member_port'] = "8080"
default['haproxy']['app_server_role'] = "webserver"
default['haproxy']['balance_algorithm'] = "roundrobin"
default['haproxy']['member_max_connections'] = "100"
default['haproxy']['x_forwarded_for'] = false
default['haproxy']['enable_ssl'] = true
default['haproxy']['ssl_incoming_port'] = "443"
default['haproxy']['ssl_member_port'] = "8443"
default['haproxy']['check_uri'] = "/"
default['haproxy']['alt_port_check'] = false
default['haproxy']['alt_port'] = "80"
default['haproxy']['enable_admin'] = false       #make it true if monit and stats needed and update the below attributes
#default['haproxy']['stats_url'] = "/"
#default['haproxy']['stats_user'] = "insecure_user"
#default['haproxy']['stats_password'] = "insecure_password"
#default['haproxy']['monitor_url'] = "/"

default['haproxy']['monit']['stats_url'] = 'http://127.0.0.1:22002'
