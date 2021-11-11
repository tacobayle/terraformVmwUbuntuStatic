#
# variables
#
variable "vsphere_username" {}
variable "vsphere_password" {}
variable "vsphere_server" {}

variable "vcenter" {
  type = map
  default = {
    dc            = "N1-DC"
    cluster       = "N1-Cluster1"
    datastore     = "vsanDatastore"
    network       = "N1-T1_Segment-Backend_10.7.6.0-24"
    resource_pool = "N1-Cluster1/Resources"
  }
}

variable "ssh_key" {
  type = map
  default = {
    algorithm            = "RSA"
    rsa_bits             = "4096"
    private_key_basename = "ssh_private_key_ubuntu"
    file_permission      = "0600"
  }
}

variable "contentLibrary" {
  default = {
    name = "Content Library Build new web server"
    description = "Content Library Build new web server"
    files = ["/home/christoph/Downloads/bionic-server-cloudimg-amd64.ova"]
  }
}

variable "ubuntu" {
  type = map
  default = {
    name = "backend-2"
    cpu = 1
    memory = 2048
    disk = 20
    password = "Avi_2020"
    wait_for_guest_net_routable = "false"
    template_name = "ubuntu-bionic-18.04-cloudimg-template"
    ipCidr = "10.7.6.100/24"
    netplanFile = "/etc/netplan/50-cloud-init.yaml"
    defaultGw = "10.7.6.1"
    dnsMain = "172.18.0.15"
    dnsSec = "10.206.8.131"
  }
}
