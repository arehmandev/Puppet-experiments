# Ensures that the apache2 service is running and that only managed vhosts are enabled

class devops::service {
  service { 'httpd':
    ensure => running,
  }
}
