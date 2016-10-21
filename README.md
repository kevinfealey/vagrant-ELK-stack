# Vagrant ELK Stack Environment

This Vagrantfile uses Docker and builds on the docker-elk project by @deviantony: https://github.com/deviantony/docker-elk

run:
```
vagrant up
```

Once everything is finished, Kibana will be accessible from the host machine at: http://localhost:5601/

All configuration files are also available from the host machine in the ```docker-elk``` folder, which will be created in the same folder as the Vagrantfile during setup.
