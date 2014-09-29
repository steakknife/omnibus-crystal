name "tgz_package"
default_version "0.0.1"

build do
  block do
    destination = File.expand_path('pkg', Omnibus::Config.project_root)
    version = "#{project.build_version}-#{project.build_iteration}"
    tgz_name = "crystal-#{version}-#{ohai['os']}-#{ohai['kernel']['machine']}.tar.gz"
    if mac_os_x?
      transform = "-s /./crystal-#{version}/"
    else
      transform = %(--transform="s/./crystal-#{version}/")
    end

    command "tar czf #{destination}/#{tgz_name} #{transform} -C #{install_dir} .",
      env: {"COPYFILE_DISABLE" => "1"}
  end
end
