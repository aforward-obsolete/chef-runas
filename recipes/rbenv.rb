
%w(zlib1g-dev openssl libopenssl-ruby1.9.1 libssl-dev libruby1.9.1 libreadline-dev git-core).each do |p|
  package p
end

git "/usr/local/rbenv" do
  repository "git://github.com/sstephenson/rbenv.git"
  user 'root'
  group 'root'
  depth 1
end

rbenv_sh = <<-EOS
# rbenv setup
export RBENV_ROOT=/usr/local/rbenv
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"
EOS

directory "/etc/profile.d"

file "/etc/profile.d/rbenv.sh" do
  mode "0755"
  action :create
  content rbenv_sh
end

# execute "source /etc/profile.d/rbenv.sh" do
#   command "source /etc/profile.d/rbenv.sh"
# end

git "/tmp/ruby-build" do
  repository "git://github.com/sstephenson/ruby-build.git"
  user 'root'
  group 'root'
  depth 1
end

execute "./install.sh" do
  cwd "/tmp/ruby-build"
end
        
execute "Enabled rbenv as root user" do
  command "echo \"export PATH=/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH\" | cat - /root/.bashrc > /tmp/tmp.bashrc && mv /tmp/tmp.bashrc /root/.bashrc"
  only_if {`cat /root/.bashrc | grep "export PATH=/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH"`.strip == ""}
end
