#
# Cookbook Name:: CBmaster
# Recipe:: default
#
# Copyright 2015, Ciaran Byrne
#
# All rights reserved - Do Not Redistribute
#

# install the ruby gems that will be required to by the node
include_recipe 'CBmaster::ruby_env_setup'

# import the files required for knife and chef
include_recipe 'CBmaster::import_files'

# update aws credentials
include_recipe 'CBmaster::update_creds'

# set cron job on node to run after chef-client finishes
include_recipe 'CBmaster::set_cron_jobs'
