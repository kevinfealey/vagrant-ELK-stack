# Vagrant ELK Stack Environment for PFSense

This Vagrantfile uses Docker and builds on my fork of the docker-elk project by @deviantony: https://github.com/kevinfealey/docker-elk

After following the instructions below, a VM environment should exist to allow remote logging of PFSense syslog data. Once the VM is running, simply log into your PFSense dashboard, select Status -> System Logs -> and put the location of the logstash instance in the "remote log servers" box at the bottom. By default, this will be "exampleHostname:5000". Then choose your desired options on the remainder of the page and save. Data will begin appearing in the Kibana dashboard within a minute.

To use:
1. Clone project
2. Modify the values in vagrant_vars.yaml. These will be used by the Vagrant file. 
3. Modify data/logstash/conf.d/11-pfsense.conf per the comments at the top of the file
4. run:
```
vagrant up
```

Once the VM is running and fully-configured, setup of ElasticSearch, Logstash, and Kibana will take several minutes (usually 5-10, especially if you have ElasticSearch data in the data/elasticsearch/data folder). You can monitor the status via docker logs commands:
```
docker logs -f dockerelk_elasticsearch_1
docker logs -f dockerelk_logstash_1
docker logs -f dockerelk_kibana_1
```
The above commands will tail stdout of the containers to your console.

Once everything is finished, Kibana will be accessible, depending on the configuration you provided in vagrant_vars.yaml, at:

http://localhost:5601
or

http://exampleHostname:5601

Kibana should be accessible from the Host machine. If the ```networkAccess```, ```vagrant_gateway```, and ```network_gateway``` variables were correctly configured in vargant_vars.yaml, Kibana will also be accessible from elsewhere on your internal network.

All configuration files are also available from the host machine in the ```docker-elk``` and ```data``` folders, which will be created in the same folder as the Vagrantfile during setup.

Note that ElasticSearch data will be preserved in the data/elasticsearch/data folder. This folder should not be deleted when destroying this VM unless you also want to delete all ElasticSearch data. 
