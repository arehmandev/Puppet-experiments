# Install webserver requirements

class devops::install {
  package { 'httpd':
    ensure => 'latest',
  }
}
