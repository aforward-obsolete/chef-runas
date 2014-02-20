
execute "apt-get update -y"
execute "apt-get upgrade -y"

["mysql-server", "mysql-client"].each do |p|
  package "#{p}"
end

execute 'mysql_install_db' do
  command "mysql_install_db && touch /etc/chef/.mysql_install_db.complete"
  not_if { File.exists?("/etc/chef/.mysql_install_db.complete")  }
end

bash 'mysql_secure_installation' do
  code <<-EOH
    mysql -uroot <<EOF && touch /etc/chef/.mysql_secure_installation.complete
-- remove anonymous users
DELETE FROM mysql.user WHERE User='';
-- Disallow root login remotely
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
-- Remove test database and access to it
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
-- Reload privilege tables now
FLUSH PRIVILEGES;
EOF
  EOH
  not_if { File.exists?('/etc/chef/.mysql_secure_installation.complete')  }
end

["php5", "libapache2-mod-php5", "php5-mcrypt","php5-mysql"].each do |p|
  package "#{p}"
end