#
# Cookbook Name:: CBmaster
# Recipe:: set_cron_jobs
#
# Copyright 2015, Ciaran Byrne
#
# All rights reserved - Do Not Redistribute
#

# check into chef server to keep in line with recipe changes
cron 'chef_check_in' do
	minute '0'
	command "sudo chef-client"
end

# Run file which will get space used on the
# slave set up most recently. When trigger
# hit start another slave server and bootstrap
# to chef
cron 'slave_check' do
	minute '*/10'
	command "ruby /home/ec2-user/check_slave_capacity.rb"
end