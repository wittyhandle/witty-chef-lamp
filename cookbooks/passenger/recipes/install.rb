#
# Cookbook Name:: passenger
# Recipe:: install

gem_package "passenger/system" do
  package_name 'passenger'
  version node[:passenger][:version]
  not_if "test -e /usr/local/bin/rvm"
end

gem_package "passenger/rvm" do
  package_name 'passenger'
  version node[:passenger][:version]
  gem_binary "/usr/local/bin/rvm default exec gem"
  only_if "test -e /usr/local/bin/rvm"
end

gem_package "bundler/system" do
  package_name 'bundler'
  not_if "test -e /usr/local/bin/rvm"
end

gem_package "bundler/rvm" do
  package_name 'bundler'
  gem_binary "/usr/local/bin/rvm default exec gem"
  only_if "test -e /usr/local/bin/rvm"
end

ruby_block 'set-passenger-paths' do
  block do
    passenger_root = if ::File.exists?("/usr/local/bin/rvm")
        `/usr/local/bin/rvm default exec passenger-config --root`.chomp
      else
        `passenger-config --root`.chomp
      end

    node.default[:passenger][:root_path] = passenger_root
    node.default[:passenger][:module_path] = passenger_root + "/ext/apache2/mod_passenger.so"
    if ::File.exists?('/usr/local/bin/rvm')
      node.default[:passenger][:ruby] = '/usr/local/rvm/wrappers/default/ruby'
    else
      node.default[:passenger][:ruby] = node[:languages][:ruby][:ruby_bin]
    end
  end
end
