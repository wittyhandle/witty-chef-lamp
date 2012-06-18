gem_package "mysql" do
  action :install
end

package "phpmyadmin"

template "/etc/phpmyadmin/config-db.php" do
  source "config-db.php.erb"
  mode 0640
  owner "root"
  group "www-data"
  variables(
    :password => node[:mysql][:server_root_password]
  )
end

cookbook_file "/home/vagrant/create_tables.sql" do
  source "create_tables.sql"
  mode 0444
  owner "root"
  group "root"
end

bash "import phpmyadmin database to support its features" do
  not_if("/usr/bin/mysql -uroot -p#{node[:mysql][:server_root_password]} -e 'show databases' | grep phpmyadmin")
  code "mysql -uroot -p#{node[:mysql][:server_root_password]} < /home/vagrant/create_tables.sql"
end