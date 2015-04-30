#
# Cookbook Name:: CBmaster
# Recipe:: default
#
# Copyright 2015, Ciaran Byrne
#
# All rights reserved - Do Not Redistribute
#

# place the slave checker on the node
cookbook_file 'check_slave_capacity.rb' do
	path '/home/ec2-user/check_slave_capacity.rb'
	action :create
end

# place the server launcher on the node
cookbook_file 'launch_new_slave.rb' do
	path 'home/ec2-user/launch_new_slave.rb'
	action :create
end

# place the access key on the node
cookbook_file 'chefPair.pem' do
	path '/home/ec2-user/chefPair.pem'
	action :create
end

cookbook_file 'ciarancbbyrne-validator.pem' do
	path '/home/ec2-user/ciarancbbyrne-validator.pem'
	action :create
end

cookbook_file 'flipdrop.pem' do
	path '/home/ec2-user/flipdrop.pem'
	action :create
end

cookbook_file 'knife.rb' do
	path 'home/ec2-user/knife.rb'
	action :create
end
