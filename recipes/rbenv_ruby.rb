include_recipe("runas::rbenv")

["install_ruby","global_ruby"].each do |f|
  template "/tmp/#{f}" do
    user 'root'
    group 'root'
    mode 0755
    source "#{f}.erb"
  end
end

execute "install_ruby" do
  cwd "/tmp"
  command "./install_ruby"
  not_if { File.exists?("/usr/local/rbenv/versions/#{node[:runas][:ruby_version]}") }
end

wrong_version = `ruby -v | grep #{node[:runas][:ruby_version]}`.strip.empty?
execute "global_ruby" do
  cwd "/tmp"
  command "./global_ruby"
  only_if { wrong_version }
end
