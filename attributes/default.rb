default[:runas][:user] = 'deployer'
default[:runas][:password] = 'PLEASE_FILL_ME_IN'
default[:runas][:group] = 'www-data'
default[:runas][:dir_path] = "/home/#{default[:runas][:user]}"
default[:runas][:install_path] = "/home/#{default[:runas][:user]}/local"
default[:runas][:noexec] = false


default[:runas][:github_username] = nil 
default[:runas][:github_email] = nil