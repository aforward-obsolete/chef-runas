#
# Cookbook Name:: runas
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "runas::user"

# Set new user in the sudoer list
# node['authorization']['sudo']['users'] << node[:runas][:user]

[local_dir,bin_dir,log_dir,pids_dir,scripts_dir].each do |d|
  directory d do
    owner node[:runas][:user]
    group node[:runas][:group]
  end
end

execute "ldconfig /home/#{node[:runas][:user]}/local/lib"