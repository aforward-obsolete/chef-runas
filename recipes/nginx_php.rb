
include_recipe "runas::nginx"

"php5-fpm".split.each do |p|
  package p
end

template "/etc/php5/fpm/php.ini" do
  owner "root"
  group "root"
  mode 0644
  source 'php.ini.erb'
end

template "/etc/php5/fpm/pool.d/www.conf" do
  owner "root"
  group "root"
  mode 0644
  source 'www.conf.erb'
end
