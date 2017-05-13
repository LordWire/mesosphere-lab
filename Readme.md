# mesosphere-lab

**mesosphere-lab** is a set of scripts to setup mesosphere on a local cluster of Vagrant boxes. It consists of a Vagrantfile to init and maintain the virtual hardware, and a complete ansible environment that will setup the mesosphere ecosystem on it. 


## Setting up

### Prerequisites

The environment was tested with the following software versions, on MacOS 10.12.4 and Fedora 25. Other versions may also work (especially ansible) but they were not tested.

- ansible (>=2.3.0)
- Vagrant (>=1.8.5) 
- VirtualBox (>=5.1)


### Basic Installation instructions


1). Install the required vagrant plugins
```
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-vbguest
```


2). Clone the repository and start the VMs
```
git clone <the repository>
cd mesosphere-lab
vagrant up --provider=virtualbox
```
Go grab a coffee, because this step will take some time.

3). Install mesosphere 
```
cd ansible
ansible-playbook provision.yml
```
This will also take some time, depending on your internet connection speed. 

4). After the installation finishes, the following will be available:

[Mesos master](http://node1:5050)

[Marathon GUI](http://node1:8080) 

On this point, you can start deploying applications on Marathon.


## Advanced configuration

The whole system is based on two nodes, but it can be easily expanded and upscaled to test Mesos scaling capabilities.



