# -*- mode: ruby -*-
# vi: set ft=ruby :

# import custom variables
require 'yaml'
settings = YAML.load_file './vagrant_vars.yaml'

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
	config.vm.box = "ubuntu/trusty64"
	if (defined?(settings['guest_hostname']).nil?)
		# do nothing if hostname var is not defined
	else
		config.vm.hostname = settings['guest_hostname']
	end
	
	config.vm.box_check_update = true
   
	# Create a public network, which generally matched to bridged network.
	# Bridged networks make the machine appear as another physical device on
	# your network.
	if (defined?(settings['guest_mac_addr']).nil?)
		config.vm.network "public_network"
	else
		config.vm.network "public_network", mac: settings['guest_mac_addr'] #set mac so we can get a static IP from DHCP
	end
	
	$gatewayUpdate_script = <<SCRIPT
		#update gateway to allow it to respond outside of localhost
		#if there is a current default gateway set to $VAGRANT_GATEWAY
		echo "Setting default route."
		if [ -n  "`ip route | grep 'default via '$VAGRANT_GATEWAY`" ]; then 
			route del default gw $VAGRANT_GATEWAY
			route add default gw $NETWORK_GATEWAY
			echo "Default route set."
			
			#echo "Updating password for vagrant user."
			#passwd --stdin vagrant <<< "$VAGRANT_PASSWORD"
		else 
			echo "Default route already set correctly."
		fi
SCRIPT
	
	if (settings['networkAccess'] == "true")
		#update gateway to allow it to respond outside of localhost -- comment this line out if you only want access to the services via IP/hostname from localhost
		config.vm.provision "shell", run: "always", inline: $gatewayUpdate_script, env: {"VAGRANT_GATEWAY" => settings['vagrant_gateway'], "NETWORK_GATEWAY" => settings['network_gateway'], "VAGRANT_PASSWORD" => settings['vagrant_user_password']}
	end
	
	if (settings['localhostAccess'] == "true")
		#If you want to access these services via localhost (i.e. http://localhost:5601 for Kibana), set localhostAccess to true. Otherwise use the above to access services via the guest hostname or IP
		config.vm.network "forwarded_port", guest: 5601, host: 5601 #kibana
		config.vm.network "forwarded_port", guest: 9200, host: 9200 #elasticsearch
		config.vm.network "forwarded_port", guest: 9300, host: 9300 #elasticsearch
		config.vm.network "forwarded_port", guest: 5000, host: 5000 #logstash
	end
	
   config.vm.provider "virtualbox" do |vb|
      vb.memory = "3072"
   end
 
   config.vm.provision "shell", inline: <<-SHELL
	apt-get update
	#apt-get upgrade
	
	apt-get -y install curl
	curl -fsSL https://get.docker.com/ | sh
	usermod -aG docker vagrant
	apt-get -y install python-pip
	pip install docker-compose
	
	apt-get -y install git 
	
	cd /vagrant
	git clone https://github.com/kevinfealey/docker-elk.git

	sysctl -w vm.max_map_count=262144

	sh runCompose.sh
   SHELL
end
