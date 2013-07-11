
include_recipe("runas::rbenv")

[
  "rbenv install #{node[:runas][:ruby_version]}",
  "rbenv global #{node[:runas][:ruby_version]}",
  "rbenv rehash"
].each do |cmd|
  execute "#{cmd}" do
    not_if { File.exists?("/usr/local/rbenv/versions/#{node[:runas][:ruby_version]}") }
  end
end
