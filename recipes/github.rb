

execute "Enabled GIT by not verifying SSL" do
  command "echo \"export GIT_SSL_NO_VERIFY=1\" | cat - /root/.bashrc > /tmp/tmp.bashrc && mv /tmp/tmp.bashrc /root/.bashrc"
  only_if {`cat /root/.bashrc | grep "export GIT_SSL_NO_VERIFY=1"`.strip == ""}
end
ENV['GIT_SSL_NO_VERIFY'] = "1"

unless node[:runas][:github_name].nil?
  execute "git config --global user.name \"#{node[:runas][:github_name]}\""
  generate_ssh_keys "root" do
    user_path "/root"
  end
end

unless node[:runas][:github_email].nil?
  execute "git config --global user.email #{node[:runas][:github_email]}"
end