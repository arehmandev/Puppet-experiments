# Overarching class

class devops {
  $myvhosts = hiera('devops::vhost', {})
  create_resources('devops::vhost', $myvhosts)
}
