# ruby to get ip addresses of all slaves
# used by GUI
require 'rubygems'
require 'chef'

class IpFinder

	def list_ips

		# connect to Chef API
		Chef::Config.from_file("MYCONFIGFILE")
		Chef::Log.level = Chef::Config[:log_level]
		$slave_search = Chef::Search::Query.new

		# print all slave ips to GUI
		$slave_search.search(:node, "recipe:CBsql") do |node_info|
			priv_ip = node_info.ipaddress
			puts priv_ip
		end
	end
end