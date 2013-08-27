
%w(openssl build-essential xorg libssl-dev).each do |p|
  package p
end

arch = node['kernel']['machine'] =~ /x86_64/ ? "amd64" : "i386"
bin_name = "wkhtmltopdf-#{arch}"
filename = "wkhtmltopdf-#{node[:runas][:wkhtmltopdf_version]}-static-#{arch}.tar.bz2"

cookbook_file "/tmp/#{filename}" do
  source filename
  owner 'root'
  group 'root'
  mode '0644'
end

execute "tar xvjf #{filename}" do
  cwd "/tmp"
  user 'root'
  group 'root'
  not_if { File.exists?("/tmp/#{bin_name}") }
end

execute "cp #{bin_name} #{node[:runas][:wkhtmltopdf_bin_path]}/wkhtmltopdf" do
  cwd "/tmp"
  user 'root'
  group 'root'
  only_if { `wkhtmltopdf -V | grep #{node[:runas][:wkhtmltopdf_print_version]}`.empty? }
end
