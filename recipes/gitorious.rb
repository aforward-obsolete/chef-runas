
src = "#{node[:gitorious][:src_dir]}/gitorious"

git "#{src}" do
  repository "#{node[:gitorious][:gir_url]}"
  user 'root'
  group 'root'
  depth 1
  notifies :run, "execute[install_gitorious]", :immediately
end

execute "install_gitorious" do
  command "./install"
  cwd "#{src}"
end