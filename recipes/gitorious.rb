
src = "#{node[:gitorious][:src_dir]}/gitorious"

git "#{src}" do
  repository "#{node[:gitorious][:gir_url]}"
  action :sync
  notifies :run, "execute[install_gitorious]", :immediately
end

execute "install_gitorious" do
  command "./install"
  cwd "#{src}"
end




default[:gitorious][:gir_url] = "https://git.gitorious.org/gitorious/ce-installer.git"
default[:gitorious][:src_dir] = "/usr/local/src"
default[:gitorious][:setup_file] = "/etc/"

git 
git clone  && cd ce-installer