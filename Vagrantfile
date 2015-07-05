VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  # Ne pas synchroniser le contenu du répertoire
  config.vm.synced_folder ".", "/vagrant", disabled: true
  
  config.vm.box = "debian/jessie64"
  
  config.vm.define "consul-master" do |machine|
    machine.vm.hostname = "consulmaster"
    machine.vm.network "private_network", ip: "172.28.0.2", netmask: "255.255.128.0"
  end
  
  config.vm.define "client1" do |machine|
    machine.vm.hostname = "client1"
    machine.vm.network "private_network", ip: "172.28.1.2", netmask: "255.255.128.0"
  end
  
  config.vm.define "client2" do |machine|
    machine.vm.hostname = "client2"
    machine.vm.network "private_network", ip: "172.28.2.2", netmask: "255.255.128.0"
  end
  
  config.vm.provision "ansible" do |ansible|
      ansible.playbook = "masterize/playbook.yml"
      
      ansible.groups = {
        "consul-master" => ["consul-master"],
        "client" => ["client1", "client2"]
      }
  end
  
end
