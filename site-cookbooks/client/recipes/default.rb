node[:clients].each do |c|
  
  directory "/var/www/#{c}" do
    owner "root"
    group "root"
    mode "0755"
    recursive true
  end

  link "/var/www/#{c}/htdocs" do
    to "/home/vagrant/#{c}/main"
  end

  directory "/var/www/#{c}/cgi-bin" do
    owner "root"
    group "root"
    mode "0755"
  end

  directory "#{node[:apache][:log_dir]}/#{c}" do
    owner "root"
    group "root"
    mode "0755"
  end

  web_app c do
    docroot "/var/www/#{c}/htdocs"
    cgiroot "/var/www/#{c}/cgi-bin"
    template "vhost.conf.erb"
    server_admin "mikeottinger@gmail.com"
    server_name "#{c}.#{node[:name]}"
  end

end