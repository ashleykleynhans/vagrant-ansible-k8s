MASTER_NODES = 3
WORKER_NODES = 2

MASTER_IP_START = 10
WORKER_IP_START = 20
LB_IP_START = 30

IMAGE_NAME = "ubuntu/focal64"
PUBLIC_IP_NW = "192.168.56."
PRIVATE_IP_NW = "10.10.10."

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure("2") do |config|
    config.vm.box = IMAGE_NAME
    config.vm.box_check_update = false
    config.ssh.insert_key = false

    # Provision Load Balancer Node
    config.vm.define "k8s-lb" do |node|
        node.vm.provider "virtualbox" do |vb|
            vb.name = "k8s-lb"
            vb.memory = 512
            vb.cpus = 1
            vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
            vb.customize ["modifyvm", :id, "--nested-hw-virt","on"]
            vb.customize ["modifyvm", :id, "--cpuhotplug","on"]
            vb.customize ["modifyvm", :id, "--audio", "none"]
            vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
            vb.customize ["modifyvm", :id, "--nictype2", "virtio"]
            vb.customize ["modifyvm", :id, "--nictype3", "virtio"]
        end
        node.vm.hostname = "k8s-lb"
        node.vm.network :public_network, ip: PUBLIC_IP_NW + "#{LB_IP_START}", bridge: [
            "eth0",
            "en0: Wi-Fi",
            "en0: Wi-Fi (AirPort)",
            "en0: Wi-Fi (Wireless)",
        ]
        node.vm.network :private_network, ip: PRIVATE_IP_NW + "#{LB_IP_START}"
        node.vm.provision "ansible" do |ansible|
            ansible.playbook = "ansible/playbooks/loadbalancer.yml"
            ansible.extra_vars = {
                node_ip: PUBLIC_IP_NW + "#{LB_IP_START}",
            }
        end
    end

    # Provision Master Nodes
    (1..MASTER_NODES).each do |i|
        config.vm.define "k8s-master-#{i}" do |node|
            # Name shown in the GUI
            node.vm.provider "virtualbox" do |vb|
                vb.name = "k8s-master-#{i}"
                vb.memory = 2048
                vb.cpus = 2
                vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
                vb.customize ["modifyvm", :id, "--nested-hw-virt","on"]
                vb.customize ["modifyvm", :id, "--cpuhotplug","on"]
                vb.customize ["modifyvm", :id, "--audio", "none"]
                vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
                vb.customize ["modifyvm", :id, "--nictype2", "virtio"]
                vb.customize ["modifyvm", :id, "--nictype3", "virtio"]
            end
            node.vm.hostname = "k8s-master-#{i}"
            node.vm.network :public_network, ip: PUBLIC_IP_NW + "#{MASTER_IP_START + i}", bridge: [
                "eth0",
                "en0: Wi-Fi",
                "en0: Wi-Fi (AirPort)",
                "en0: Wi-Fi (Wireless)",
            ]
            node.vm.network :private_network, ip: PRIVATE_IP_NW + "#{MASTER_IP_START + i}"
            node.vm.provision "ansible" do |ansible|
                if i == 1
                    ansible.playbook = "ansible/playbooks/master_primary.yml"
                else
                    ansible.playbook = "ansible/playbooks/master_secondary.yml"
                end
                ansible.extra_vars = {
                    node_ip: PUBLIC_IP_NW + "#{MASTER_IP_START + i}",
                }
            end
        end
    end

    # Provision Worker Nodes
    (1..WORKER_NODES).each do |i|
        config.vm.define "k8s-worker-#{i}" do |node|
            node.vm.provider "virtualbox" do |vb|
                vb.name = "k8s-worker-#{i}"
                vb.memory = 512
                vb.cpus = 1
                vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
                vb.customize ["modifyvm", :id, "--nested-hw-virt","on"]
                vb.customize ["modifyvm", :id, "--cpuhotplug","on"]
                vb.customize ["modifyvm", :id, "--audio", "none"]
                vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
                vb.customize ["modifyvm", :id, "--nictype2", "virtio"]
                vb.customize ["modifyvm", :id, "--nictype3", "virtio"]
            end
            node.vm.hostname = "k8s-worker-#{i}"
            node.vm.network :public_network, ip: PUBLIC_IP_NW + "#{WORKER_IP_START + i}", bridge: [
                "eth0",
                "en0: Wi-Fi",
                "en0: Wi-Fi (AirPort)",
                "en0: Wi-Fi (Wireless)",
            ]
            node.vm.network :private_network, ip: PRIVATE_IP_NW + "#{WORKER_IP_START + i}"
            node.vm.provision "ansible" do |ansible|
                ansible.playbook = "ansible/playbooks/worker.yml"
                ansible.extra_vars = {
                    node_ip: PUBLIC_IP_NW + "#{WORKER_IP_START + i}",
                }
            end
        end
    end
end
