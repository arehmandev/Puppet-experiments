# Defined type to create vhosts on webservers
# If source is set then the file will be downloaded to vhost location
# By default the source is not updated every time the puppet is run
# Change $refresh_source to true if vhost should be updated every
# time puppet runs
# ip address and port are set to 0.0.0.0 and 80 by default

define devops::vhost($source = false, $refresh_source = false, $ip = '0.0.0.0', $port = '80') {
  require devops::install
  require devops::config
  include devops::service
  include devops::firewall
  # Check if we have valid hostnames
  case $name {
    /\s/: {
      fail("vhost string '${name}' invalid - should have no spaces")
    }
      default: {}
  }
  file { "/var/www/${name}":
    ensure => directory,
  }
  file {
    "/etc/httpd/sites-available/${name}.conf":
      content => template('devops/vhost.erb');
    "/etc/httpd/sites-enabled/${name}.conf":
      ensure => link,
      target => "../sites-available/${name}.conf",
      notify  => Service['httpd'];
  }
  if $source != false {
    exec { "download ${name}":
      command => "wget ${source} -P /var/www/${name}",
      path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
      unless  => "test -f /var/www/${name}/no_refresh",
      before  => File["/var/www/${name}/no_refresh"],
    }
    if $refresh_source == false {
      file { "/var/www/${name}/no_refresh":
        ensure => present,
      }
    }
    else {
      file { "/var/www/${name}/no_refresh":
        ensure => absent,
      }
    }
  }
}
