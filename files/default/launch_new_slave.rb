# ruby to launch new slave server on ec2 and
# bootstrap to Chef server
require 'rubygems'
require 'aws-sdk'

class LaunchSlave

	# pass in the node number to associate in Chef
	def lets_run(new_node_id)

		node_id = new_node_id.to_s
		
		# connect to AWS API
		ec2 = Aws::EC2::Client.new(
			region: 'eu-west-1',
			credentials: Aws::Credentials.new("AWSACCESSKEYID", "AWSSECRETACCESSKEY"),
			)

		# launch new server instance
		new_inst = ec2.run_instances(
			:image_id => "MYIMAGEID",
			:instance_type => "MYINSTANCESIZE",
			:min_count => 1,
			:max_count => 1,
			:security_groups => ['MYSECURITYGROUP'],
			:key_name => "MYKEYNAME"
			)

		begin
			# wait until instance running, then get instance private ip
			ec2.wait_until(:instance_running, instance_ids:[new_inst.instances[0].instance_id])
			run_details = ec2.describe_instances(instance_ids:[new_inst.instances[0].instance_id])
			private_ip_add = run_details.reservations[0].instances[0].private_ip_address
			puts "Instance #{new_inst.instances[0].instance_id} running as #{private_ip_add}"

			# wait for OK status then bootstrap to Chef
			ec2.wait_until(:instance_status_ok, instance_ids:[new_inst.instances[0].instance_id])
			puts "#{private_ip_add} has OK status"
			`knife bootstrap #{private_ip_add} -x ec2-user --sudo -i /home/ec2-user/MYKEYNAME.pem -r recipe[CBsql] -N #{node_id}`
			puts "Finished configuring #{private_ip_add}"
			
		rescue Aws::Waiters::Errors::WaiterFailed => error
			puts "failed waiting for instance: #{error.message}"	
		end
	end
end