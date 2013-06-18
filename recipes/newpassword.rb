set_passwd node[:runas][:user] do
  password node[:runas][:password]
end
