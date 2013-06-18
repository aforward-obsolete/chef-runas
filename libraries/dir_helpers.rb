module DirHelpers
  def home_dir
    "#{node[:runas][:dir_path]}"
  end
  
  def local_dir
    "#{home_dir}/local"
  end
  
  def bin_dir
    "#{home_dir}/local/bin"
  end

  def sbin_dir
    "#{home_dir}/local/sbin"
  end

  def lib_dir
    "#{home_dir}/local/lib"
  end
  
  def log_dir
    "#{local_dir}/log"
  end

  def pids_dir
    "#{local_dir}/pids"
  end
  
  def fireup_dir
    "#{local_dir}/fireup"
  end
  
  def include_dir(sub_dir = nil)
    if sub_dir
      File.join(local_dir,"include",sub_dir)
    else
      File.join(local_dir,"include")
    end
  end
end

class Chef::Recipe
  include DirHelpers
end

class Chef::Resource
  include DirHelpers
end

class Chef::ResourceDefinition
  include DirHelpers
end

class Chef::Recipe
  include DirHelpers
end

class Chef::Resource
  include DirHelpers
end

class Chef::ResourceDefinition
  include DirHelpers
end
