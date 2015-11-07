VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Config réseau pour VirtualBox, afin de réussir les bridges
  # Voir https://github.com/jpetazzo/pipework pour plus d'infos
  config.vm.provider "virtualbox" do |v|
    v.customize ['modifyvm', :id, '--nicpromisc1', 'allow-all']
  end

  # Ne pas synchroniser le contenu du répertoire
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Debian Jessie
  config.vm.box = "debian/jessie64"

  # Master consul

  config.vm.define "consul-master" do |machine|
    machine.vm.hostname = "consulmaster"
    machine.vm.network "private_network", ip: "172.28.0.2", netmask: "255.255.255.0"
  end

  # Clients consul

  clients = 1..2

  clients.each do |num|
    config.vm.define "client#{num}" do |machine|
      ip_end = 2 + num
      machine.vm.hostname = "client#{num}"
      machine.vm.network "private_network", ip: "172.28.0.#{ip_end}", netmask: "255.255.255.0"
    end
  end

  # Masterization des machines avec Ansible

  config.vm.provision "ansible" do |ansible|
      ansible.playbook = "masterize/playbook.yml"

      ansible.groups = {
        "consul-master" => ["consul-master"],
        "client" => clients.map { |num| "client#{num}" }
      }
  end

end
