name "phpstack"
description "Nodes that run php with apache and mysql"
run_list %w(apt vim ntp apache2 apache2::mod_php5 php::module_curl mysql::server phpmyadmin client)
override_attributes "apache" => { "listen_ports" => [80] }