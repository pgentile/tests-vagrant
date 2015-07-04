VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  # Ne pas synchroniser le contenu du répertoire
  config.vm.synced_folder ".", "/vagrant", disabled: true
  
  config.vm.network "private_network", type: "dhcp"
  
  config.vm.box = "debian/jessie64"
  config.vm.hostname = "miniprod"
    
  config.vm.provision "ansible" do |ansible|
      ansible.playbook = "provisioning/site.yml"
      ansible.verbose = "v"
      
      ansible.extra_vars = {
        vagrant_user: "vagrant"
      }
  end
  
end
