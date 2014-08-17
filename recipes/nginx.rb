include_recipe "nginx"

include_recipe "ghost-blog::common"

template "/etc/nginx/sites-available/ghost" do
  source "nginx-site.erb"
  variables(
    :dir     => ::File.join(node[:ghost][:install_path], "ghost")
  )
  notifies :restart, "service[nginx]"
end

### Workaround for default config in conf.d instead of sites-enabled.
template "/etc/nginx/conf.d/default.conf" do
  source "nginx-default.erb"
  notifies :restart, "service[nginx]"
end

nginx_site "ghost" do
  enable true
  template false
end

