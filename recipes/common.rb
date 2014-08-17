include_recipe "nodejs::npm"

directory node[:ghost][:user] do
	owner node[:ghost][:user]
	group node[:ghost][:user]
	mode "0755"
	recursive true
	action :create
end

include_recipe "ark"

ark 'ghost' do
	url node[:ghost][:src_url]
	path node[:ghost][:install_path]
	owner node[:ghost][:user]
	strip_leading_dir false
	action :put
end

extract_dir = ::File.join(node[:ghost][:install_path], "ghost")

# Hacky way to work around the ark bug which messes up extraction
bash "remove_ark_junk" do
	cwd extract_dir
	code "rm -rf *"
end

bash "unzip_ghost" do
  cwd Chef::Config[:file_cache_path]
  code "unzip -q -u -o #{Chef::Config[:file_cache_path]}/ghost.zip -d #{extract_dir}"
  not_if do
    File.exists?("#{extract_dir}/config.js")
  end
end

template ::File.join(extract_dir, "config.js") do
	source "config.js.erb"
	owner node[:ghost][:user]
	group node[:ghost][:user]
	mode "0660"
	variables(
		:include_dev_config => node[:ghost][:include_dev_config],
		:url => node[:ghost][:domain],
		:sqlite_path_dev => node[:ghost][:sqlite_path_dev],
		:sqlite_path_prod => node[:ghost][:sqlite_path_prod],
		:blog_addr => node[:ghost][:blog_addr],
		:blog_port => node[:ghost][:blog_port]
 	)
end

bash "install_ghost" do
	cwd extract_dir
	code "npm install --production"
end

bash "set_ownership" do
  cwd node[:ghost][:install_path]
  code "chown -R #{node[:ghost][:user]}:#{node[:ghost][:user]} #{node[:ghost][:install_path]}"
end

case node[:platform]
when "ubuntu"
  if node["platform_version"].to_f >= 9.10
    template "/etc/init/ghost.conf" do
      source "ghost.conf.erb"
      mode "0644"
      variables(
        :user		=> node[:ghost][:user],
        :dir		=> extract_dir
      )
    end
  end
end

service "ghost" do
  case node["platform"]
  when "ubuntu"
    if node["platform_version"].to_f >= 9.10
      provider Chef::Provider::Service::Upstart
    end
  end
  action [ :enable, :start ]
end

