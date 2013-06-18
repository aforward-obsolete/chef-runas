# Create the main user e.g. deployer
user node[:runas][:user] do
  comment "#{node[:runas][:user]} (I run stuff)"
  gid node[:runas][:group]
  home home_dir
  shell "/bin/bash"
  supports :manage_home => true
end
