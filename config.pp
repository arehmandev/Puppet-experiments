# Class to configure apache

class devops::config {
  require devops::install
  file { '/etc/httpd/sites-available':
    ensure  => 'directory',
    recurse => true,
    purge   => true,
  }
  file { '/etc/httpd/sites-enabled':
    ensure  => 'directory',
    recurse => true,
    purge   => true,
  }
  file { '/etc/httpd/conf/httpd.conf':
    source => 'puppet:///modules/devops/httpd.conf',
  }
}
