define :generate_ssh_keys, :user_path => nil do
  username = params[:name]
  user_path = params[:user_path] || "/home/#{username}"
  raise ":username should be provided." if username.nil?
  
  Chef::Log.debug("generate ssh skys for #{username}.")
  execute "generate ssh skys for #{username}." do
    user username
    creates "#{user_path}/.ssh/id_rsa.pub"
    command "ssh-keygen -t rsa -q -f #{user_path}/.ssh/id_rsa -P \"\""
  end
end