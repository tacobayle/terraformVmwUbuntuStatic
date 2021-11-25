output "ubuntu_static_ips" {
  value = vsphere_virtual_machine.ubuntu_static.*.default_ip_address
}

output "ubuntu_dhcp_ips" {
  value = vsphere_virtual_machine.ubuntu_dhcp.*.default_ip_address
}

//output "ssh_private_key_path" {
//  value = "~/.ssh/${var.ssh_key.private_key_basename}.pem"
//}