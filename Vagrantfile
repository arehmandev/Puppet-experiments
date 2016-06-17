# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "kaplan-centos-7.0-64-puppet-3.8-preinstall"
  config.vm.box_url = "https://s3-eu-west-1.amazonaws.com/kaplan-vagrant-images/kaplan-centos-7.0-64-puppet-3.8-preinstall.box"
  config.vm.hostname = "web.devops.test"
  config.vm.network "forwarded_port", guest: 80, host: 8080,
      auto_correct: true

  # Provision via puppet.
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path    = "modules"
    puppet.manifest_file  = "default.pp"
    puppet.hiera_config_path = "hiera.yaml"
    puppet.options = "--verbose"
  end
end
