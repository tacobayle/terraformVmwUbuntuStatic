output "ubuntu_static_ips" {
  value = vsphere_virtual_machine.ubuntu_static.*.default_ip_address
}

output "ubuntu_dhcp_ips" {
  value = vsphere_virtual_machine.ubuntu_dhcp.*.default_ip_address
}

output "ubuntu_username" {
  value = var.ubuntu.username
}

output "ubuntu_password" {
  value = var.ubuntu.password
}

//output "ssh_private_key_path" {
//  value = "~/.ssh/${var.ssh_key.private_key_basename}.pem"
//}