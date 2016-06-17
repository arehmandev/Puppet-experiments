# This allows access on port 80 to the webserver
# Should be managed by an iptables module rather than an exec

class devops::firewall {
  exec { 'allow access on port 80':
    command => 'iptables -I IN_public_allow -p tcp --dport 80 -j ACCEPT',
    path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
  }
}
