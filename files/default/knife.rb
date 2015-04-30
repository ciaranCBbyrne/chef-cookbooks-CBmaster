# See http://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "flipdrop"
client_key               "/home/ec2-user/flipdrop.pem"
validation_client_name   "ciarancbbyrne-validator"
validation_key           "/home/ec2-user/ciarancbbyrne-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/ciarancbbyrne"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
knife[:aws_access_key_id]	= "AKIAIIH36JBX4F7I5BGA"
knife[:aws_secret_access_key] = "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"
knife[:region] = "eu-west-1"
knife[:aws_ssh_key_id] = "chefPair"
knife[:identity_file] = "/home/ec2-user/chefPair.pem"