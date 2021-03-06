# ruby to manage slave servers of a system. methods will manage
# connections to the Chef server API and connnecting to slaves
# through ssh.
require 'net/ssh'
require 'rubygems'
require 'json'
require 'chef'

class CheckSlave

	# set up connection to Chef API with credentials
	Chef::Config.from_file("MYCONFIGFILE")
	Chef::Log.level = Chef::Config[:log_level]
	$slave_search = Chef::Search::Query.new

	# find and return private ip of any slave.
	# pass in the node number to search for.
	def find_any_server(server_number)

		ssh_address = ""

		$slave_search.search(:node, "name:#{server_number}") do |node_info|

			ssh_address = node_info.ipaddress
		end
		return ssh_address
	end

	# find and return node number and private ip of the newest
	# slave set up on Chef
	def find_max_server

		server_node_id = 0
		ssh_address = ""

		$slave_search.search(:node, "recipe:CBsql") do |node_info|

			name = node_info.name
			name_id = name.to_i

			if name_id > server_node_id then

				server_node_id = name_id
				ssh_address =  node_info.ipaddress
			end
		end
		return server_node_id, ssh_address
	end

	# connect to slave and find space information. return percentage reached.
	# pass in ip address to connect to.
	def get_capacity(slave_address)

		# store all information obtained in hash
		output = Hash.new

		begin
			#open connection through ssh
			Net::SSH.start("#{slave_address.to_s}", 'ec2-user', :keys => 'MYSSHKEYS') do |ssh|
				# get system memory info from node in json format
				taken =  ssh.exec!("sudo ohai filesystem") # see chef-cookbooks-CBsql/recipes/update_sudo_tty.rb or this won't be allowed
				# convert json to hash
				output = JSON.parse(taken)

				# get space details from hash
				kb_size = output['/dev/xvda1']['kb_size'].to_i
				kb_used = output['/dev/xvda1']['kb_used'].to_i
				kb_available = output['/dev/xvda1']['kb_available'].to_i

				# print free memory of node for GUI
				puts slave_address
				puts
				puts "size: #{kb_size} kb"
				puts "used: #{kb_used} kb"
				puts "avail: #{kb_available} kb"

				# if node is 90% new slave will be launched
				$capacity_reached = (kb_used.to_i * 100 ) / kb_size.to_i
				puts
				puts "#{$capacity_reached}% used"
				return $capacity_reached
			end
		rescue Net::SSH::HostKeyMismatch => e
			puts "Problem connecting to slave."
			puts "Please wait and try again"
			retry
		rescue StandardError => e
			puts "Something happened!!!"
			puts e
			return 0
		end
	end
end