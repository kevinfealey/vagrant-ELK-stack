# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
   config.vm.box = "ubuntu/trusty64"
   config.vm.box_check_update = true
   config.vm.network "forwarded_port", guest: 5601, host: 5601
   
   config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
   end
 
   config.vm.provision "shell", inline: <<-SHELL
	apt-get update
	apt-get -y install curl
	curl -fsSL https://get.docker.com/ | sh
	usermod -aG docker vagrant
	apt-get -y install python-pip
	pip install docker-compose
	
	cd /vagrant
	git clone https://github.com/kevinfealey/docker-elk.git
	
	sysctl -w vm.max_map_count=262144

	cd /vagrant/docker-elk
	docker-compose up -d --build
   SHELL
  # Kibana will be accessible from the host machine at: http://localhost:5601/
end
