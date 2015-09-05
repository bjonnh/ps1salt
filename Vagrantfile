# -*- mode: ruby -*-
# vi: set ft=ruby :

# make sure you have the Oracle VM VirtualBox Extension Pack install in 
# addition to virtualbox

VAGRANTFILE_API_VERSION = "2"
$script = <<SCRIPT
pacman -Sy --noconfirm
pacman -S archlinux-keyring --noconfirm
pacman -S --noconfirm salt-zmq
SCRIPT
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "arch" do |arch|
      arch.vm.box = "archlinux-x86_64"
      arch.vm.box_url = "http://cloud.terry.im/vagrant/archlinux-x86_64.box"
      arch.vm.hostname = "arch"
  end

  config.vm.synced_folder ".", "/srv/salt/"

  config.vm.provider "virtualbox" do |vb|
     vb.gui = true
     vb.customize ["modifyvm", :id, "--memory", "1024"]
  end
  config.vm.provision "shell", inline: $script
  config.vm.provision :salt do |salt|
      salt.minion_config = "vagrant/minion"
      salt.run_highstate = true
  end

end
