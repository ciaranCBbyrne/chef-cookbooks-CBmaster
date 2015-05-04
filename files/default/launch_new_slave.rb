require 'rubygems'
require 'yaml'
require 'aws-sdk'

class LaunchSlave

	def lets_run(new_node_id)

		# works
		ec2 = Aws::EC2::Client.new(
			region: 'eu-west-1',
			credentials: Aws::Credentials.new("AWSACCESSKEYID", "AWSSECRETACCESSKEY"),
			)


		# works
		new_inst = ec2.run_instances(
			:image_id => "MYIMAGEID",
			:instance_type => "MYINSTANCESIZE",
			:min_count => 1,
			:max_count => 1,
			:security_groups => ['MYSECURITYGROUP'],
			:key_name => "MYKEYNAME"
			)


		begin
			# works
			puts "Waiting for #{new_inst.instances[0].instance_id} to be running"
			ec2.wait_until(:instance_running, instance_ids:[new_inst.instances[0].instance_id])
			run_details = ec2.describe_instances(instance_ids:[ new_inst.instances[0].instance_id])

			pub_ip_add = run_details.reservations[0].instances[0].public_ip_address
			puts "Waiting for #{pub_ip_add} to have OK status"
			ec2.wait_until(:instance_status_ok, instance_ids:[new_inst.instances[0].instance_id])

			puts "Bootstrapping #{pub_ip_add}"
			`knife bootstrap #{pub_ip_add} -x ec2-user --sudo -i /home/ec2-user/MYKEYNAME.pem -r recipe[CBsql] -N #{new_node_id}`
			puts "Completed launch and bootstrap"
			
			# gotta check
		rescue Aws::Waiters::Errors::WaiterFailed => error
			puts "failed waiting for instance running: #{error.message}"	
		end
	end
end