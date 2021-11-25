

data "template_file" "ubuntu_userdata_static" {
  template = file("${path.module}/userdata/ubuntu.userdata")
  count            = (var.dhcp == false ? 1 : 0)
  vars = {
    password      = var.ubuntu.password
    pubkey        = chomp(tls_private_key.ssh.public_key_openssh)
    ipCidr = var.ubuntu.ipCidr
    ip = split("/", var.ubuntu.ipCidr)[0]
    defaultGw = var.ubuntu.defaultGw
    dnsMain = var.ubuntu.dnsMain
    dnsSec = var.ubuntu.dnsSec
    netplanFile = var.ubuntu.netplanFile
  }
}

data "template_file" "ubuntu_userdata_dhcp" {
  template = file("${path.module}/userdata/ubuntu_dhcp.userdata")
  count            = (var.dhcp == true ? 1 : 0)
  vars = {
    password      = var.ubuntu.password
    pubkey        = chomp(tls_private_key.ssh.public_key_openssh)
  }
}

resource "vsphere_virtual_machine" "ubuntu_static" {
  count            = (var.dhcp == false ? var.ubuntu.count : 0)
  name             = var.ubuntu.name
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  network_interface {
                      network_id = data.vsphere_network.network.id
  }

  num_cpus = var.ubuntu.cpu
  memory = var.ubuntu.memory
  wait_for_guest_net_routable = var.ubuntu.wait_for_guest_net_routable
  guest_id = "guestid-${var.ubuntu.name}"

  disk {
    size             = var.ubuntu.disk
    label            = "${var.ubuntu.name}.lab_vmdk"
    thin_provisioned = true
  }

  cdrom {
    client_device = true
  }

  clone {
    template_uuid = vsphere_content_library_item.file.id
  }

  vapp {
    properties = {
     hostname    = var.ubuntu.name
     password    = var.ubuntu.password
     public-keys = chomp(tls_private_key.ssh.public_key_openssh)
     user-data   = base64encode(data.template_file.ubuntu_userdata_static[0].rendered)
   }
 }

  connection {
   host        = split("/", var.ubuntu.ipCidr)[0]
   type        = "ssh"
   agent       = false
   user        = "ubuntu"
   private_key = tls_private_key.ssh.private_key_pem
  }

  provisioner "remote-exec" {
   inline      = [
     "while [ ! -f /tmp/cloudInitDone.log ]; do sleep 1; done"
   ]
  }
}

resource "vsphere_virtual_machine" "ubuntu_dhcp" {
  count            = (var.dhcp == true ? var.ubuntu.count : 0)
  name             = var.ubuntu.name
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  network_interface {
    network_id = data.vsphere_network.network.id
  }

  num_cpus = var.ubuntu.cpu
  memory = var.ubuntu.memory
  wait_for_guest_net_routable = var.ubuntu.wait_for_guest_net_routable
  guest_id = "guestid-${var.ubuntu.name}"

  disk {
    size             = var.ubuntu.disk
    label            = "${var.ubuntu.name}.lab_vmdk"
    thin_provisioned = true
  }

  cdrom {
    client_device = true
  }

  clone {
    template_uuid = vsphere_content_library_item.file.id
  }

  vapp {
    properties = {
      hostname    = var.ubuntu.name
      password    = var.ubuntu.password
      public-keys = chomp(tls_private_key.ssh.public_key_openssh)
      user-data   = base64encode(data.template_file.ubuntu_userdata_dhcp[0].rendered)
    }
  }

  connection {
    host        = vsphere_virtual_machine.ubuntu_dhcp.default_ip_address
    type        = "ssh"
    agent       = false
    user        = "ubuntu"
    private_key = tls_private_key.ssh.private_key_pem
  }

  provisioner "remote-exec" {
    inline      = [
      "while [ ! -f /tmp/cloudInitDone.log ]; do sleep 1; done"
    ]
  }
}