directory "#{node[:www_dir]}/htdocs" do
  owner "root"
  group "root"
  mode "0755"
  recursive true
end

directory "#{node[:www_dir]}/cgi-bin" do
  owner "root"
  group "root"
  mode "0755"
end

directory "#{node[:apache][:log_dir]}/carl" do
  owner "root"
  group "root"
  mode "0755"
end

web_app "carl" do
  docroot "#{node[:www_dir]}/htdocs"
  cgiroot "#{node[:www_dir]}/cgi-bin"
  template "vhost.conf.erb"
  server_admin "mikeottinger@gmail.com"
  server_name "carl.#{node[:name]}"
end