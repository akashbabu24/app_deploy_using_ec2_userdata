#
# Cookbook Name:: activemq
# Attributes:: default
#
#

default['activemq']['mirror']  = "http://apache.mirrors.tds.net"
default['activemq']['version'] = "5.15.12"
default['activemq']['home']  = "/opt"
default['activemq']['wrapper']['max_memory'] = "512"
default['activemq']['wrapper']['useDedicatedTaskRunner'] = "true"
