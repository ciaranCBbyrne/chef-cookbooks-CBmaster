require 'minitest/spec'

describe_recipe 'CBmaster::update_creds' do 

	describe "updated files" do

		it "launch_new_slave has been updated" do
			$file_name = "#{node.default['CBmaster']['dir']['docs']}/launch_new_slave.rb"
			file("#{$file_name}").must_include "#{node.default['CBmaster']['aws']['aws_access_key_id']}"
			file("#{$file_name}").must_include "#{node.default['CBmaster']['aws']['aws_secret_access_key']}"
			file("#{$file_name}").must_include "#{node.default['CBmaster']['ec2']['image_id']}"
			file("#{$file_name}").must_include "#{node.default['CBmaster']['ec2']['flavor']}"
			file("#{$file_name}").must_include "#{node.default['CBmaster']['ec2']['security_group']}"
			file("#{$file_name}").must_include "#{node.default['CBmaster']['ec2']['key_name']}"
		end

		it "knife has been updated" do
			$file_name = "#{node.default['CBmaster']['dir']['knife_location']}/knife.rb"
			file("#{$file_name}").must_include "#{node.default['CBmaster']['chef']['node_name']}"
			file("#{$file_name}").must_include "#{node.default['CBmaster']['dir']['docs']}/#{node.default['CBmaster']['chef']['server_acc_key']}"
			file("#{$file_name}").must_include "#{node.default['CBmaster']['chef']['validation_client_name']}"
			file("#{$file_name}").must_include "#{node.default['CBmaster']['dir']['docs']}/#{node.default['CBmaster']['chef']['org_acc_key']}"
			file("#{$file_name}").must_include "#{node.default['CBmaster']['chef']['server_url']}"
			file("#{$file_name}").must_include "#{node.default['CBmaster']['aws']['aws_access_key_id']}"
			file("#{$file_name}").must_include "#{node.default['CBmaster']['aws']['aws_secret_access_key']}"
			file("#{$file_name}").must_include "#{node.default['CBmaster']['ec2']['key_name']}"
			file("#{$file_name}").must_include "#{node.default['CBmaster']['dir']['docs']}/#{node.default['CBmaster']['aws']['ssh_key_pair']}"
		end

		it "check_slave_capacity has been updated" do
			$file_name = "#{node.default['CBmaster']['dir']['docs']}/check_slave_capacity.rb"
			file("#{$file_name}").must_include "#{node.default['CBmaster']['dir']['knife_location']}/#{node.default['CBmaster']['chef']['knife_file']}"
			file("#{$file_name}").must_include "#{node.default['CBmaster']['dir']['docs']}/#{node.default['CBmaster']['aws']['ssh_key_pair']}"
		end

		it "delete_slave has been updated" do
			$file_name = "#{node.default['CBmaster']['dir']['docs']}/delete_slave.rb"
			file("#{$file_name}").must_include "#{node.default['CBmaster']['dir']['knife_location']}/#{node.default['CBmaster']['chef']['knife_file']}"
			file("#{$file_name}").must_include "#{node.default['CBmaster']['aws']['aws_access_key_id']}"
			file("#{$file_name}").must_include "#{node.default['CBmaster']['aws']['aws_secret_access_key']}"
		end

		it "slave_ip_list has been updated" do
			$file_name = "#{node.default['CBmaster']['dir']['docs']}/slave_ip_list.rb"
			file("#{$file_name}").must_include "#{node.default['CBmaster']['dir']['knife_location']}/#{node.default['CBmaster']['chef']['knife_file']}"
		end
	end
end