name 'java_se'
maintainer ''
maintainer_email ''
description "Installs Oracle's Java SE JDK"
chef_version '>= 11.0' if respond_to?(:chef_version)
version '8.131.0'

supports 'centos'
supports 'debian'
supports 'fedora'
supports 'mac_os_x'
supports 'redhat'
supports 'ubuntu'
supports 'windows'
