package "nginx"

execute "rm -f /etc/nginx/sites-enabled/default"

template "/etc/init/nginx.conf" do
  owner "root"
  group "root"
  mode 0700
  source 'nginx.init.erb'
end

template "/etc/nginx/nginx.conf" do
  owner "root"
  group "root"
  mode 0700
  source 'nginx.conf.erb'
end

service "nginx" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [ :enable ]
end

file "/etc/nginx/sites-available/default" do
  action :delete
  notifies :run, "execute[service nginx restart]"
end

execute "service nginx restart" do
  action :nothing
end

