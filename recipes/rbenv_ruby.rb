
include_recipe("runas::rbenv")

[
  "ruby-build #{node[:runas][:ruby_version]} /usr/local/rbenv/versions/#{node[:runas][:ruby_version]} --with-openssl-dir=/usr/local",
  "rbenv global #{node[:runas][:ruby_version]}",
  "rbenv rehash"
].each do |cmd|
  execute "#{cmd}" do
    not_if { File.exists?("/usr/local/rbenv/versions/#{node[:runas][:ruby_version]}") }
  end
end
