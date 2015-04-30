require 'net/ssh'
require 'rubygems'
require 'json'
require '/home/ec2-user/launch_new_slave'
require 'chef'

# credantials for chef server located in knife
Chef::Config.from_file("/home/ec2-user/knife.rb")
Chef::Log.level = Chef::Config[:log_level]


# search chef server to get ip_address of newest slave created
ssh_address = ""
server_node_id = 0

Chef::Search::Query.new.search(:node, "recipe:CBsql") do |node_info|
	name = node_info.name
	name_id = name.to_i
	if name_id > server_node_id then
		server_node_id = name_id
		ssh_address =  node_info.ipaddress
	end
end

# open connection through ssh and get filesystem info
output = Hash.new

Net::SSH.start("#{ssh_address}", 'ec2-user', :keys => '/home/ec2-user/chefPair.pem') do |ssh|
	# get system memory info from node in json format
	taken =  ssh.exec!("sudo ohai filesystem") # see recipes/update_sudo_tty.rb if getting error from sudo
	# convert json to hash
	output = JSON.parse(taken)

	# get space details from hash
	kb_size = output['/dev/xvda1']['kb_size'].to_i
	kb_used = output['/dev/xvda1']['kb_used'].to_i
	kb_available = output['/dev/xvda1']['kb_available'].to_i

	# print free memory of node
	puts ssh_address
	puts "Time : #{Time.now}"
	puts "size: #{kb_size} kb"
	puts "used: #{kb_used} kb"
	puts "avail: #{kb_available} kb"

	# work out percentage of space used
	$capacity_reached = (kb_used.to_i * 100 ) / kb_size.to_i 
end

# if node is 90% launch new slave
if $capacity_reached.to_i >= 90 then
	puts "90% reached"
	launch = LaunchSlave.new
	launch.lets_run(server_node_id + 1)
end