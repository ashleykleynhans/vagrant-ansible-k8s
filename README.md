# vagrant-ansible-k8s

Provision a High Availability Multi Master Kubernetes Cluster using Vagrant, Virtualbox and Ansible with the following configuration:

* 3 Kubernetes master nodes that manage the cluster
* 2 Kubernetes worker nodes where the Docker containers will be deployed to
* 1 HAProxy Load Balancer to achieve High Availability across the master nodes

## Requirements

At least the following hardware resources will be required on the host machine that will be running the VirtualBox guest VMs:

| VM           | CPU | Memory |
|--------------|-----|--------|
| k8s-lb       | 1   | 512MB  |
| k8s-master-1 | 2   | 2GB    |
| k8s-master-2 | 2   | 2GB    |
| k8s-master-3 | 2   | 2GB    |
| k8s-worker-1 | 1   | 512MB  |

## Clone the GitHub Repository

Run the following command from the terminal to clone the GitHub Repository:

```bash
git clone https://github.com/ashleykleynhans/vagrant-ansible-k8s.git
```

## Install Required Software

Begin by installing the homebrew package manager, which works on both Mac
 and Ubuntu Linux.  May work on other Linux distributions but has not bee
n tested.

Run the following command from the terminal to install homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

All of the remaining software can be installed by cloning the git repository and  running the setup script provided.

Run the setup script from the terminal to install the required software:

```bassh
./setup.sh
```

## Managing the Stack

Begin by ensuring that you are in the directory which the Github Repository was cloned to:

```
cd vagrant-ansible-k8s
```

### Starting the Stack

This will provision the following Virtual Box VMs using Vagrant and Ansible:

| VM Name        | Description                                       |
|----------------|---------------------------------------------------|
| k8s-lb         | HAProxy Load Balancer to ensure High Availability |
| k8s-master-1   | Kubernetes Primary Master Node                    |
| k8s-master-2   | Kubernetes Secondary Master Node                  |
| k8s-master-3   | Kubernetes Secondary Master Node                  |
| k8s-worker-1   | Kubernetes Worker where Docker Containers wll run |
| k8s-worker-2   | Kubernetes Worker where Docker Containers wll run |


```bash
vagrant up
```

### Stopping the Stack

```bash
vagrant halt
```

### Deleting the Stack

```bash
vagrant destroy -f
```
