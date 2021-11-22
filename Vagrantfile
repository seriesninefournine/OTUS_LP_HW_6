# -*- mode: ruby -*-
# vim: set ft=ruby :

ENV["LC_ALL"] = "en_US.UTF-8"

#Формируем настройки виртуальных машин
MACHINES = {
  :data_server => {
    :hostname => 'server',
    :ip_addr => '10.0.0.10',
  }
  #,
  #:data_client => {
  #  :hostname => 'client',
  #  :ip_addr => '10.0.0.11',
  #}
}

Vagrant.configure("2") do |config|
  MACHINES.each do |boxname, boxconfig|
    config.vm.define boxname do |box|

      config.vm.box = 'centos/8.4'
      config.vm.box_url = 'https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-Vagrant-8.4.2105-20210603.0.x86_64.vagrant-virtualbox.box'
      config.vm.box_download_checksum = 'dfe4a34e59eb3056a6fe67625454c3607cbc52ae941aeba0498c29ee7cb9ac22'
      config.vm.box_download_checksum_type = 'sha256'

      box.vm.host_name = boxconfig[:hostname]
      box.vm.network "private_network", ip: boxconfig[:ip_addr]
      box.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "512"]
      end

      if boxconfig[:hostname] == 'server'
        box.vm.provision "shell", path: "startup_script_server.sh"
      end
      #if boxconfig[:hostname] == 'client'
      #  box.vm.provision "shell", path: "startup_script_client.sh"
      #end
      
    end
  end
end