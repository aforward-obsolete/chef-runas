# Install expect since the scripts below need it
package "expect"

# Using the expect script we can generate the ssh-key
cookbook_file "/tmp/ssh-keygen_no_prompt" do
  mode 0755
end

execute "ssh-keygen_no_prompt" do
  command "/tmp/ssh-keygen_no_prompt #{home_dir}/.ssh/id_dsa"
  creates "#{home_dir}/.ssh/id_dsa"
  user node[:runas][:user]
  group node[:runas][:group]
end

execute "chown #{node[:runas][:user]}:#{node[:runas][:group]} #{home_dir}/.ssh/id_dsa"
execute "chown #{node[:runas][:user]}:#{node[:runas][:group]} #{home_dir}/.ssh/id_dsa.pub"

cookbook_file "/tmp/ssh_no_prompt" do
  mode 0755
end

cookbook_file "/tmp/scp_no_prompt" do
  mode 0755
end

directory "#{home_dir}/.ssh/remote_servers" do
  owner node[:runas][:user]
  group node[:runas][:group]
end

if node[:runas][:remote_users].empty?
  Chef::Log.info("No remote access required fro this server.")
else

  node[:runas][:remote_users].each_with_index do |user,index|
    password = node[:runas][:remote_passwords][index]
    server = node[:runas][:remote_servers][index]
    Chef::Log.info("Checking for access of #{user} on #{server}...")
    access_filename = "#{home_dir}/.ssh/remote_servers/#{user}@#{server}"
    next if File.exists?(access_filename)
    Chef::Log.info("ACCESS REQUIRED... (#{user} on #{server}).")
    execute "/tmp/scp_no_prompt #{server} #{user} #{password} #{home_dir}/.ssh/id_dsa.pub newkey.pub"
    execute "/tmp/ssh_no_prompt #{server} #{user} #{password} \"cat newkey.pub >> .ssh/authorized_keys\""
    file "#{access_filename}" do
      mode "644"
      owner node[:runas][:user]
      group node[:runas][:group]
    end  
  end

end

