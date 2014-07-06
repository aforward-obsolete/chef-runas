
include_recipe "runas::nginx"

"php5-fpm".split.each do |p|
  package p
end

template "/etc/php5/fpm/php.ini" do
  owner "root"
  group "root"
  mode 0644
  source 'php.ini.erb'
  notifies :run, "execute[php5-fpm reload]"
end

template "/etc/php5/fpm/pool.d/www.conf" do
  owner "root"
  group "root"
  mode 0644
  source 'www.conf.erb'
  notifies :run, "execute[php5-fpm reload]"
end

execute "php5-fpm reload" do
  command "/etc/init.d/php5-fpm reload"
  action :nothing
end

