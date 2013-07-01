define :set_passwd do
  # Install expect to easily set the password for the user
  package "expect"
  
  # Using the expect script we can set the password
  cookbook_file "/tmp/passwd_no_prompt" do
    mode 0755
  end
  # Can be run everytime since changing the password to the same thing should be harmless
  execute "passwd_no_prompt" do
    puts "ABOUT TO SET PASSWORD [#{params[:name]}] [#{params[:password]}]"
    command "/tmp/passwd_no_prompt #{params[:name]} #{params[:password]}"
  end
end
