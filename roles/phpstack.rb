name "phpstack"
description "Nodes that run php with apache and mysql"
run_list %w(vim ntp apache2 apache2::mod_php5 vhost mysql::server phpmyadmin)
override_attributes "apache" => { "listen_ports" => [80] }

# will it work?