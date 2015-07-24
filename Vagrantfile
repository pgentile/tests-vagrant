VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  # Ne pas synchroniser le contenu du répertoire
  config.vm.synced_folder ".", "/vagrant", disabled: true
  
  config.vm.box = "debian/jessie64"
  
  config.vm.define "consul-master" do |machine|
    machine.vm.hostname = "consulmaster"
    machine.vm.network "private_network", ip: "172.28.0.2", netmask: "255.255.128.0"
  end
  
  clients = 1..3
  
  clients.each do |num|
    config.vm.define "client#{num}" do |machine|
      machine.vm.hostname = "client#{num}"
      machine.vm.network "private_network", ip: "172.28.#{num}.2", netmask: "255.255.128.0"
    end
  end
  
  config.vm.provision "ansible" do |ansible|
      ansible.playbook = "masterize/playbook.yml"
      
      ansible.groups = {
        "consul-master" => ["consul-master"],
        "client" => clients.map { |num| "client#{num}" }
      }
  end
  
end
