# vagrant-ansible-k8s

Provision a High Availability Multi Master Kubernetes Cluster on Ubuntu 22.04 LTS servers using Vagrant, Virtualbox and Ansible with the following configuration:

* 3 Kubernetes master nodes that manage the cluster
* 2 Kubernetes worker nodes where the Docker containers will be deployed to
* 1 HAProxy Load Balancer to achieve High Availability across the master nodes

With a default Kubernetes configuration, no external IP addresses are assigned when a LoadBalancer service is created.

Fortunately [MetalLB](https://metallb.universe.tf/) solves this problem, and has been implented to allow external IP addresses to be assigned to Load Balancers in the Kubernetes Cluster.

The configuration can be viewed on [Github](https://github.com/ashleykleynhans/vagrant-ansible-k8s/blob/master/k8s/metallb-config.yml).

## Requirements

At least the following hardware resources will be required on the host machine that will be running the VirtualBox guest VMs:

| VM           | CPU | Memory |
|--------------|-----|--------|
| k8s-lb       |  1  | 512MB  |
| k8s-master-1 |  2  | 2GB    |
| k8s-master-2 |  2  | 2GB    |
| k8s-master-3 |  2  | 2GB    |
| k8s-worker-1 |  1  | 512MB  |
| k8s-worker-2 |  1  | 512MB  |
|              |     |        |
| TOTAL        |  5  | 7.5GB  |

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

## Deploying an Application

SSH to one of the k8s masters:

```bash
vagrant ssh k8s-master-1
```

Then run the following command to deploy 2 pods running nginx to the k8s cluster:

```bash
kubectl apply -f https://raw.githubusercontent.com/ashleykleynhans/vagrant-ansible-k8s/master/k8s/deployment.yml
```

Then deploy a service that will use MetalLB to expose the nginx application outside of the k8s cluster:

```bash
kubectl apply -f https://raw.githubusercontent.com/ashleykleynhans/vagrant-ansible-k8s/master/k8s/service.yml
```

Now you will be able to access nginx through your web browser at:

[http://10.10.10.180/](http://10.10.10.180/)
