MASTER_NODES = 2
WORKER_NODES = 2

MASTER_IP_START = 10
WORKER_IP_START = 20
LB_IP_START = 30

IMAGE_NAME = "ubuntu/focal64"
IP_NW = "192.168.56."

Vagrant.configure("2") do |config|
    config.vm.box = IMAGE_NAME
    config.vm.box_check_update = false
    config.ssh.insert_key = false

    # Provision Master Nodes
    (1..MASTER_NODES).each do |i|
        config.vm.define "k8s-master-#{i}" do |node|
            # Name shown in the GUI
            node.vm.provider "virtualbox" do |vb|
                vb.name = "k8s-master-#{i}"
                vb.memory = 2048
                vb.cpus = 2
            end
            node.vm.hostname = "k8s-master-#{i}"
            node.vm.network :private_network, ip: IP_NW + "#{MASTER_IP_START + i}"
            node.vm.network "forwarded_port", guest: 22, host: "#{2710 + i}"
            node.vm.provision "ansible" do |ansible|
                ansible.playbook = "ansible/master.yml"
                ansible.extra_vars = {
                    node_ip: IP_NW + "#{MASTER_IP_START + i}",
                }
            end
        end
    end

    # Provision Load Balancer Node
    config.vm.define "k8s-lb" do |node|
        node.vm.provider "virtualbox" do |vb|
            vb.name = "k8s-lb"
            vb.memory = 512
            vb.cpus = 1
        end
        node.vm.hostname = "k8s-lb"
        node.vm.network :private_network, ip: IP_NW + "#{LB_IP_START}"
        node.vm.network "forwarded_port", guest: 22, host: 2730
        node.vm.provision "ansible" do |ansible|
            ansible.playbook = "ansible/loadbalancer.yml"
            ansible.extra_vars = {
                node_ip: IP_NW + "#{LB_IP_START}",
            }
        end
    end

    # Provision Worker Nodes
    (1..WORKER_NODES).each do |i|
        config.vm.define "k8s-worker-#{i}" do |node|
            node.vm.provider "virtualbox" do |vb|
                vb.name = "k8s-worker-#{i}"
                vb.memory = 512
                vb.cpus = 1
            end
            node.vm.hostname = "k8s-worker-#{i}"
            node.vm.network :private_network, ip: IP_NW + "#{WORKER_IP_START + i}"
		        node.vm.network "forwarded_port", guest: 22, host: "#{2720 + i}"
            node.vm.provision "ansible" do |ansible|
                ansible.playbook = "ansible/worker.yml"
                ansible.extra_vars = {
                    node_ip: IP_NW + "#{WORKER_IP_START + i}",
                }
            end
        end
    end
end
