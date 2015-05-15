# ruby script to manage getting information on
# any slave specified by ip address.
# used by the GUI
require '/home/ec2-user/check_slave_capacity'

class GetSlaveInfo

	def get_info
		slave_ip = ARGV[0]
		# declare class in check_slave_capacity
		check_slave = CheckSlave.new

		# call method to get information
		# catch if taking too long
		begin
			Timeout::timeout(10) do
				capacity = check_slave.get_capacity(slave_ip)
			end
		rescue Timeout::Error
			puts "Timed out trying to connect to slave."
			puts "Please wait and try again"
		end
	end
end