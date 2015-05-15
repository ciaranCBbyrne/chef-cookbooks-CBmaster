require 'minitest/spec'

describe_recipe 'CBmaster::ruby_env_setup_test' do 

	describe "installed packages" do

		it "installed gcc" do
			package("gcc").must_be_installed
		end

		it "installed mysql-devel" do
			package("mysql-devel").must_be_installed
		end

		it "installed ruby-devel" do
			package("ruby-devel").must_be_installed
		end

		it "installed rubygems" do
			package("rubygems").must_be_installed
		end
	end
end