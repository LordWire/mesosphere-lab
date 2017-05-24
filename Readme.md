# mesosphere-lab

**mesosphere-lab** is a set of scripts to setup mesosphere on a local cluster of Vagrant boxes. It consists of a Vagrantfile to init and maintain the virtual hardware, and a complete ansible environment that will setup the mesosphere ecosystem on it. 


## Setting up

### Prerequisites

The environment was tested with the following software versions, on MacOS 10.12.4 and Fedora 25. Other versions may also work (especially ansible) but they were not tested.

- ansible (>=2.3.0)
- Vagrant (>=1.8.5) 
- VirtualBox (>=5.1.22)


### Basic Installation instructions

1). Install prerequisites
```bash
sudo dnf install VirtualBox vagrant ansible ruby-devel
# ruby-devel is ruby-dev for apt-based systems
```

2). Install the required vagrant plugins
```bash
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-vbguest
```


3). Clone the repository and start the VMs
```bash
git clone <the repository>
cd mesosphere-lab
vagrant up --provider=virtualbox
```
Go grab a coffee, because this step will take some time.

4). Install mesosphere 
```bash
cd ansible
ansible-playbook provision.yml
```
This will also take some time, depending on your internet connection speed. 

5). After the installation finishes, the following will be available:

[Mesos master](http://node1:5050)

[Marathon GUI](http://node1:8080) 

On this point, you can start deploying applications on Marathon.


## Advanced configuration

The whole system is based on two nodes, but it can be easily expanded and upscaled to test Mesos scaling capabilities.



### Adding a slave node

Assume that you wish to add a new node named ```node3```:


1). First, add the new node to Vagrantfile, in the  cluster section, and provide a suitable IP: 

	cluster = {
	  "node1" => { :ip => "192.168.70.10", :cpus => 2, :mem => 2048, :cpucap => 30 },
	  "node2" => { :ip => "192.168.70.11", :cpus => 2, :mem => 2048, :cpucap => 30 }
      "node3" => {:ip => "192.168.70.12", :cpus => 2, :mem => 2048, :cpucap => 30 }
	}
    



2). Add the node to ```mesosphere-lab/ansible/hosts``` file, in whichever sections you wish. E.g, in order to make the node be a mesos-master and a mesos-slave, add it to both sections:

```diff
[mesos-masters]
node1
+node3    

[mesos-slaves]
node1
node2
+node3
```

3). Reprovision:

```bash
ansible-playbook provision.yml
```


