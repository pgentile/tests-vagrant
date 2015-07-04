VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.network "private_network", type: "dhcp"
  
  config.vm.box = "ubuntu/trusty64"
  
  config.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbook/playbook.yml"
  end
  
end
