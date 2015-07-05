VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  # Ne pas synchroniser le contenu du répertoire
  config.vm.synced_folder ".", "/vagrant", disabled: true
  
  config.vm.network "private_network", type: "dhcp"
  
  config.vm.box = "debian/jessie64"

  # TODO Rechercher le HOME en ruby, support id_dsa
  
  config.vm.define "consul-master" do |machine|
    machine.vm.hostname = "consulmaster"
  end
  
  config.vm.define "client1" do |machine|
    machine.vm.hostname = "client1"
  end
  
  config.vm.define "client2" do |machine|
    machine.vm.hostname = "client2"
  end
  
  config.vm.provision "ansible" do |ansible|
      ansible.playbook = "provisioning/site.yml"
      
      ansible.groups = {
        "consul-master" => ["consul-master"],
        "client" => ["client1", "client2"]
      }
      
      ansible.extra_vars = {
        vagrant_user: "vagrant"
      }
  end
  
end
