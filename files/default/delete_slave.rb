# delete slaves from system.
# used by the GUI
require 'rubygems'
require 'aws-sdk'
require 'chef'

class DropSlave

	def delete
		# get ip address of slave to be deleted
		slave_ip = ARGV[0].to_s

		# connect to Chef server API
		Chef::Config.from_file("MYCONFIGFILE")
		Chef::Log.level = Chef::Config[:log_level]
		$slave_search = Chef::Search::Query.new
		$destroy = Chef::REST.new(Chef::Config[:chef_server_url],Chef::Config[:node_name],Chef::Config[:client_key])

		# search for node number corresponding to the ip
		$chef_node_id
		$slave_search.search(:node, "ipaddress:#{slave_ip.to_s}") do |node|
			$chef_node_id = node.name
		end

		# delete all information from Chef server
		$destroy.delete("/nodes/#{$chef_node_id}")
		$destroy.delete("/clients/#{$chef_node_id}")
		puts "Node No. #{$chef_node_id} deleted from nodes & client list"

		# connect to AWS API 
		ec2 = Aws::EC2::Client.new(
					region: 'eu-west-1',
					credentials: Aws::Credentials.new("AWSACCESSKEYID", "AWSSECRETACCESSKEY"),
					)

		# get ec2 instance id to be deleted
		details = ec2.describe_instances(filters:[{name:"private-ip-address", values:["#{slave_ip.to_s}"],},],)
		inst_id = details.reservations[0].instances[0].instance_id

		# terminate slave on AWS
		delete = ec2.terminate_instances(instance_ids: ["#{inst_id}"])

		# wait til terminated to confirm
		ec2.wait_until(:instance_terminated, instance_ids:["#{inst_id}"])
		puts "EC2 ID #{inst_id} terminated from AWS"

	end
end