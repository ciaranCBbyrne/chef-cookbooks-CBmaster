#
# Cookbook Name:: CBmaster
# Recipe:: update_creds
#
# Copyright 2015, Ciaran Byrne
#
# All rights reserved - Do Not Redistribute
#

# update credentials in files
# node.default[...] need to be defined in an attributes/default.rb

ruby_block "update_aws_creds" do
	block do
		rc = Chef::Util::FileEdit.new("#{node.default['CBmaster']['dir']['docs']}/launch_new_slave.rb")
		rc.search_file_replace(/AWSACCESSKEYID/, "#{node.default['CBmaster']['aws']['aws_access_key_id']}")
		rc.search_file_replace(/AWSSECRETACCESSKEY/, "#{node.default['CBmaster']['aws']['aws_secret_access_key']}")
		rc.search_file_replace(/MYIMAGEID/, "#{node.default['CBmaster']['ec2']['image_id']}")
		rc.search_file_replace(/MYINSTANCESIZE/, "#{node.default['CBmaster']['ec2']['flavor']}")
		rc.search_file_replace(/MYSECURITYGROUP/, "#{node.default['CBmaster']['ec2']['security_group']}")
		rc.search_file_replace(/MYKEYNAME/, "#{node.default['CBmaster']['ec2']['key_name']}")
		rc.write_file
	end
end

ruby_block "update_chef_creds" do
	block do
		wr = Chef::Util::FileEdit.new("#{node.default['CBmaster']['dir']['knife_location']}/#{node.default['CBmaster']['chef']['knife_file']}")
		wr.search_file_replace(/MYNODENAME/, "#{node.default['CBmaster']['chef']['node_name']}")
		wr.search_file_replace(/MYCHEFSERVERKEY/, "#{node.default['CBmaster']['dir']['docs']}/#{node.default['CBmaster']['chef']['server_acc_key']}")
		wr.search_file_replace(/MYVALCLIENTNAME/, "#{node.default['CBmaster']['chef']['validation_client_name']}")
		wr.search_file_replace(/MYCHEFORGKEY/, "#{node.default['CBmaster']['dir']['docs']}/#{node.default['CBmaster']['chef']['org_acc_key']}")
		wr.search_file_replace(/MYSERVERURL/, "#{node.default['CBmaster']['chef']['server_url']}")
		wr.search_file_replace(/MYACCESSKEY/, "#{node.default['CBmaster']['aws']['aws_access_key_id']}")
		wr.search_file_replace(/MYSECRETACCESSKEY/, "#{node.default['CBmaster']['aws']['aws_secret_access_key']}")
		wr.search_file_replace(/MYKEYNAME/, "#{node.default['CBmaster']['ec2']['key_name']}")
		wr.search_file_replace(/MYSSHKEYPAIR/, "#{node.default['CBmaster']['dir']['docs']}/#{node.default['CBmaster']['aws']['ssh_key_pair']}")
		wr.write_file
	end
end

ruby_block "update_ssh_creds" do
	block do
		ch = Chef::Util::FileEdit.new("#{node.default['CBmaster']['dir']['docs']}/check_slave_capacity.rb")
		ch.search_file_replace(/MYCONFIGFILE/, "#{node.default['CBmaster']['dir']['knife_location']}/#{node.default['CBmaster']['chef']['knife_file']}")
		ch.search_file_replace(/MYSSHKEYS/, "#{node.default['CBmaster']['dir']['docs']}/#{node.default['CBmaster']['aws']['ssh_key_pair']}")
		ch.write_file
	end
end

ruby_block "update_delete_creds" do
	block do
		del = Chef::Util::FileEdit.new("#{node.default['CBmaster']['dir']['docs']}/delete_slave.rb")
		del.search_file_replace(/MYCONFIGFILE/, "#{node.default['CBmaster']['dir']['knife_location']}/#{node.default['CBmaster']['chef']['knife_file']}")	
		del.search_file_replace(/AWSACCESSKEYID/, "#{node.default['CBmaster']['aws']['aws_access_key_id']}")
		del.search_file_replace(/AWSSECRETACCESSKEY/, "#{node.default['CBmaster']['aws']['aws_secret_access_key']}")
		del.write_file
	end
end

ruby_block "update_slave_list" do
	block do
		ls = Chef::Util::FileEdit.new("#{node.default['CBmaster']['dir']['docs']}/slave_ip_list.rb")
		ls.search_file_replace(/MYCONFIGFILE/, "#{node.default['CBmaster']['dir']['knife_location']}/#{node.default['CBmaster']['chef']['knife_file']}")
		ls.write_file
	end
end