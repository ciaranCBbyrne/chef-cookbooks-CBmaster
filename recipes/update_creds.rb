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

ruby_block "update_creds" do
	block do
		rc = Chef::Util::FileEdit.new("/home/ec2-user")
		rc.search_file_replace(/AWSACCESSKEYID/, "#{node.default['CBmaster']['aws']['aws_access_key_id']}")
		rc.search_file_replace(/AWSSECRETACCESSKEY/, "#{node.default['CBmaster']['aws']['aws_secret_access_key']}")
		rc.write_file
	end	
end