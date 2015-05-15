require 'minitest/spec'

describe_recipe 'CBmaster::set_cron_jobs' do 

	describe "cron jobs" do
		
		it "chef-client checkin every hour" do
			cron("chef_check_in").must_exist.with(:minute, "8").and(:command, "sudo chef-client")
		end
		
		it "check slave every 10 mins" do
			cron("slave_check").must_exist.with(:minute, "*/10")
		end
	end
end