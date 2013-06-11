
template "/root/.vimrc" do
  source "vimrc.erb"
  mode 0644
  owner 'root'
  group 'root'
end