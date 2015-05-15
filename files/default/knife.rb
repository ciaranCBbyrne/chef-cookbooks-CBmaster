# See http://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "MYNODENAME"
client_key               "MYCHEFSERVERKEY"
validation_client_name   "MYVALCLIENTNAME"
validation_key           "MYCHEFORGKEY"
chef_server_url          "MYSERVERURL"
knife[:aws_access_key_id]	= "MYACCESSKEY"
knife[:aws_secret_access_key] = "MYSECRETACCESSKEY"
knife[:region] = "eu-west-1"
knife[:aws_ssh_key_id] = "MYKEYNAME"
knife[:identity_file] = "MYSSHKEYPAIR"