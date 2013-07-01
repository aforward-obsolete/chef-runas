directory "#{node[:runas][:dir_path]}/.ssh" do
  owner "#{node[:runas][:user]}"
  group "#{node[:runas][:group]}"
end

file "#{node[:runas][:dir_path]}/.ssh/authorized_keys" do
  owner "#{node[:runas][:user]}"
  group "#{node[:runas][:group]}"
  mode "0644"
  action :create
  content "#{node[:runas][:authorized_keys].join("\n")}"
end

["/root","#{node[:runas][:dir_path]}"].each do |d|
  file "#{d}/.ssh/known_hosts" do
    owner "#{node[:runas][:user]}"
    group "#{node[:runas][:group]}"
    mode "0644"
    action :create
    content "#{node[:runas][:known_hosts].join("\n")}"
  end
end