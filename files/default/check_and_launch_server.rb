# ruby script to manage check_slave_capacity.rb & launch_new_slave.rb

require '/home/ec2-user/check_slave_capacity'
require '/home/ec2-user/launch_new_slave'

class CheckAndLaunch

	def track

		# declare classes in rubies
		check_slave = CheckSlave.new
		launch = LaunchSlave.new

		# find latest server setup as slave
		# returns node number and private ip from chef server
		$server_node_id, $slave_ip = check_slave.find_max_server

		# if there's no slave on system
		if $server_node_id == "" then
			$server_node_id = 0
		end

		# get capacity of slave
		# allow for call from GUI without checking slave
		if ARGV.empty? then
			$capacity_reached = check_slave.get_capacity($slave_ip)
		else
			$capacity_reached = 100
		end

		# if triggered launch new slave
		if $capacity_reached.to_i >= 90 then
			launch.lets_run($server_node_id.to_i + 1)
		end
	end
end
