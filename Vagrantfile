# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

cluster = {
  "node1" => { :ip => "192.168.70.10", :cpus => 2, :mem => 2048, :cpucap => 30 },
  "node2" => { :ip => "192.168.70.11", :cpus => 2, :mem => 2048, :cpucap => 30 }
}

require './vbguest-installer-fixes_issue_8502.rb'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # vagrant-hostmanager settings
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = false

  # vagrant-vbguest settings
  config.vbguest.iso_path = "http://download.virtualbox.org/virtualbox/%{version}/VBoxGuestAdditions_%{version}.iso"
  config.vbguest.auto_update = true
  config.vbguest.no_remote = false
  config.vbguest.installer = Installer8502

  cluster.each_with_index do |(hostname, info), index|

    config.vm.define hostname do |cfg|
      # add our own personal keys to all VMs, to support normal ssh. 
      # This method is specific to ubuntu image.
      cfg.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/me.pub"
      cfg.vm.provision "shell", inline: "cat ~ubuntu/.ssh/me.pub >> ~ubuntu/.ssh/authorized_keys"
      cfg.vm.provision "shell", inline: "sudo systemctl disable apt-daily.timer" # disable ubuntu auto updaters
      cfg.vm.provision "shell", inline: "sudo systemctl disable apt-daily.service"
      cfg.vm.provision "shell", inline: "sudo apt-get -y install python"
      config.vm.box_check_update = false
      # configure hostmanager plugin
      cfg.hostmanager.aliases = hostname
      cfg.vm.provider :virtualbox do |vb, override|
        config.vm.box = "ubuntu/xenial64"
        override.vm.network :private_network, ip: "#{info[:ip]}"
        override.vm.hostname = hostname
        vb.name = hostname
        vb.customize ["modifyvm", :id, "--memory", info[:mem], "--cpus", info[:cpus], "--hwvirtex", "on", "--cpuexecutioncap", info[:cpucap] ]
        vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ] # override the default xenial64 uart console log.
      end # end provider
    end # end config

  end # end cluster
end
