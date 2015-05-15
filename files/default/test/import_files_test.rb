require 'minitest/spec'

describe_recipe 'CBmaster::import_files' do

	describe "files on node" do
		
		it "installed the check_slave_capacity file" do
			file("#{default['CBmaster']['dir']['docs']}/check_slave_capacity.rb").must_exist
		end

		it "installed the launch_new_slave file" do
			file("#{default['CBmaster']['dir']['docs']}/launch_new_slave.rb").must_exist
		end

		it "installed the check_and_launch file" do
			file("#{default['CBmaster']['dir']['docs']}/check_and_launch_server.rb").must_exist
		end

		it "installed the slave_ip_list file" do
			file("#{default['CBmaster']['dir']['docs']}/slave_ip_list.rb").must_exist
		end

		it "installed the get_any_slave_info file" do
			file("#{default['CBmaster']['dir']['docs']}/get_any_slave_info.rb").must_exist
		end

		it "installed the delete_slave file" do
			file("#{default['CBmaster']['dir']['docs']}/delete_slave.rb").must_exist
		end
	end
end	