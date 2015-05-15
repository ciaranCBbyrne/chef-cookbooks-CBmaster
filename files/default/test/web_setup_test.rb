require 'minitest/spec'

describe_recipe 'CBmaster::web_setup' do 

	describe "web files" do

		it "web directory display set up & correct owner" do
			directory("#{node.default['CBmaster']['dir']['web']}").must_exist.with(:owner,"#{node.default['CBmaster']['user']['owner']}")
		end

		it "access granted to home" do
			directory("#{node.default['CBmaster']['dir']['docs']}").must_exist.with(:owner,"#{node.default['CBmaster']['user']['owner']}").with(:mode,"#{node.default['CBmaster']['user']['mode']}")
		end

		it "background image in place" do
			file("#{node.default['CBmaster']['dir']['web']}/images/cloud_image.jpg").must_exist
		end

		it "web homepage in place" do
			file("#{node.default['CBmaster']['dir']['web']}/index.php").must_exist
		end
	end
end
