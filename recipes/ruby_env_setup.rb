#
# Cookbook Name:: CBmaster
# Recipe:: ruby_env_setup
#
# Copyright 2015, Ciaran Byrne
#
# All rights reserved - Do Not Redistribute
#

# install the packages required to run ruby and gems for the rubies

package 'gcc' do
	action :install
end

package 'mysql-devel' do
	action :install
end

package 'ruby-devel' do
	action :install
end

package 'rubygems' do
	action :install
end

gem_package 'mysql2' do
	action :install
end

gem_package 'net-ssh' do
	action :install
end

gem_package 'json' do
	action :install
end

gem_package 'aws-sdk' do
	action :install
end

gem_package 'chef' do
	action :install
end
