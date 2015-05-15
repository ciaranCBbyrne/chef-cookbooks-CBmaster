#
# Cookbook Name:: CBmaster
# Recipe:: web_setup
#
# Copyright 2015, Ciaran Byrne
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'apache2'
include_recipe 'php'
include_recipe 'apache2::mod_php5'

# create and enable custom site
web_app 'display' do
	template 'display.conf.erb'
end

directory node.default['CBmaster']['dir']['web'] do
	owner "#{node.default['CBmaster']['user']['owner']}"
	action :create
end

# allow access to ruby files from index.php
directory node.default['CBmaster']['dir']['docs'] do
	mode "#{node.default['CBmaster']['user']['mode']}"
	owner "#{node.default['CBmaster']['user']['owner']}"
end

# create document root
directory "#{node.default['CBmaster']['dir']['web']}/images" do
	recursive true
end

# image for background
cookbook_file 'cloud_image.jpg' do
	path "#{node.default['CBmaster']['dir']['web']}/images/cloud_image.jpg"
	mode '0644'
end

# write default home page
template "#{node.default['CBmaster']['dir']['web']}/index.php" do
	source 'index.php.erb'
	mode '0644'
	owner "#{node.default['CBmaster']['user']['owner']}"
	group 'ec2-user'
end

include_recipe 'iptables'
iptables_rule 'firewall_http'