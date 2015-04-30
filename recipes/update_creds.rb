#
# Cookbook Name:: CBmaster
# Recipe:: update_creds
#
# Copyright 2015, Ciaran Byrne
#
# All rights reserved - Do Not Redistribute
#

# update credentials in files from attributes

# these attributes (node.default[....]) need to be defined in a file attributes/default.rb

ruby_block "update_ruby_files" do
	block do
		rc = Chef::Util::FileEdit.new("/home/ec2-user/launch_new_slave.rb")
		rc.search_file_replace(/AWSACCESSKEYID/, node.default['CBmaster']['aws']['aws_access_key_id'])
		rc.search_file_replace(/AWSSECRETACCESSKEY/, node.default['CBmaster']['aws']['aws_secret_access_key'])
	end	
end