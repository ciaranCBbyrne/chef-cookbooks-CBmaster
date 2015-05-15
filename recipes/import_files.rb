#
# Cookbook Name:: CBmaster
# Recipe:: import_files
#
# Copyright 2015, Ciaran Byrne
#
# All rights reserved - Do Not Redistribute
#

# ruby files to check and run servers
# slave checker
cookbook_file 'check_slave_capacity.rb' do
	path "#{node.default['CBmaster']['dir']['docs']}/check_slave_capacity.rb"
	mode "#{node.default['CBmaster']['user']['mode']}"
	owner "#{node.default['CBmaster']['user']['owner']}"
	action :create
end
# server launcher
cookbook_file 'launch_new_slave.rb' do
	path "#{node.default['CBmaster']['dir']['docs']}/launch_new_slave.rb"
	mode "#{node.default['CBmaster']['user']['mode']}"
	owner "#{node.default['CBmaster']['user']['owner']}"
	action :create
end
# main class to call checker and launcher
cookbook_file 'check_and_launch_server.rb' do
	path "#{node.default['CBmaster']['dir']['docs']}/check_and_launch_server.rb"
	mode "#{node.default['CBmaster']['user']['mode']}"
	owner "#{node.default['CBmaster']['user']['owner']}"
	action :create
end
# main class to get ip address list
cookbook_file 'slave_ip_list.rb' do
	path "#{node.default['CBmaster']['dir']['docs']}/slave_ip_list.rb"
	mode "#{node.default['CBmaster']['user']['mode']}"
	owner "#{node.default['CBmaster']['user']['owner']}"
	action :create
end
cookbook_file 'get_any_slave_info.rb' do
	path "#{node.default['CBmaster']['dir']['docs']}/get_any_slave_info.rb"
	mode "#{node.default['CBmaster']['user']['mode']}"
	owner "#{node.default['CBmaster']['user']['owner']}"
	action :create
end
cookbook_file 'delete_slave.rb' do
	path "#{node.default['CBmaster']['dir']['docs']}/delete_slave.rb"
	mode "#{node.default['CBmaster']['user']['mode']}"
	owner "#{node.default['CBmaster']['user']['owner']}"
	action :create
end

# credentials required for ec2 and chef server
# access key to slaves
cookbook_file node.default['CBmaster']['aws']['ssh_key_pair'] do
	path "#{node.default['CBmaster']['dir']['docs']}/#{node.default['CBmaster']['aws']['ssh_key_pair']}"
	mode "#{node.default['CBmaster']['user']['mode']}"
	owner "#{node.default['CBmaster']['user']['owner']}"
	action :create
end
# access key to chef server organisation
cookbook_file node.default['CBmaster']['chef']['org_acc_key'] do
	path "#{node.default['CBmaster']['dir']['docs']}/#{node.default['CBmaster']['chef']['org_acc_key']}"
	mode "#{node.default['CBmaster']['user']['mode']}"
	owner "#{node.default['CBmaster']['user']['owner']}"
	action :create
end
# access key to chef server
cookbook_file node.default['CBmaster']['chef']['server_acc_key'] do
	path "#{node.default['CBmaster']['dir']['docs']}/#{node.default['CBmaster']['chef']['server_acc_key']}"
	mode "#{node.default['CBmaster']['user']['mode']}"
	owner "#{node.default['CBmaster']['user']['owner']}"
	action :create
end
# knife settings for chef and ec2
cookbook_file node.default['CBmaster']['chef']['knife_file'] do
	path "#{node.default['CBmaster']['dir']['knife_location']}/#{node.default['CBmaster']['chef']['knife_file']}"
	mode "#{node.default['CBmaster']['user']['mode']}"
	owner "#{node.default['CBmaster']['user']['owner']}"
	action :create
end
