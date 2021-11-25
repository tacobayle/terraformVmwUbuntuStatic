#
# variables
#
variable "vsphere_username" {}
variable "vsphere_password" {}

variable "vcenter" {
  type = map
  default = {
    server        = "wdc-06-vc12.oc.vmware.com"
    dc            = "wdc-06-vc12"
    cluster       = "wdc-06-vc12c01"
    datastore     = "wdc-06-vc12c01-vsan"
    network       = "vxw-dvs-34-virtualwire-3-sid-6120002-wdc-06-vc12-avi-mgmt"
    resource_pool = "wdc-06-vc12c01/Resources"
  }
}

variable "ubuntu_ip4_addresses" {
  default = ["10.206.112.56/22", "10.206.112.57/22"]
}

variable "gateway4" {
  default = "10.206.112.1"
}

variable "nameservers" {
  default = "10.206.8.130, 10.206.8.130, 10.206.8.131"
}

variable "ssh_key" {
  type = map
  default = {
    algorithm            = "RSA"
    rsa_bits             = "4096"
    private_key_basename = "ssh_private_key_tf_ubuntu_"
    file_permission      = "0600"
  }
}

variable "dhcp" {
  default = true
}

variable "content_library" {
  default = {
    basename = "content_library_tf_"
    source_url = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.ova"
  }
}

variable "ubuntu" {
  type = map
  default = {
    basename = "ubuntu-tf-"
    count = 2
    username = "ubuntu"
    cpu = 1
    memory = 2048
    disk = 20
    wait_for_guest_net_routable = "false"
    netplanFile = "/etc/netplan/50-cloud-init.yaml"
  }
}