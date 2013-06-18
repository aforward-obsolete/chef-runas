# http://wiki.mediatemple.net/w/(ve):Noexec_and_/tmp_troubleshooting
if node[:runas]["noexec"]
  directory "/var/local/tmp" do
    mode 0777
  end

  execute "mount --bind /var/local/tmp /tmp"
  # execute "umount /tmp"
end
