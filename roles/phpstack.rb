name "phpstack"
description "Nodes that run php with apache and mysql"
run_list %w(ntp apache2 apache2::mod_php5 vhost)
override_attributes "apache" => { "listen_ports" => [80] }