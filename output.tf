output "ubuntu_static_ips" {
  value = var.ubuntu_ip4_addresses.*
}

output "ubuntu_dhcp_ips" {
  value = vsphere_virtual_machine.ubuntu_dhcp.*.default_ip_address
}

output "ubuntu_username" {
  value = var.ubuntu.username
}

output "ubuntu_password" {
  value = random_string.ubuntu_password.result
}

//output "ssh_private_key_path" {
//  value = "~/.ssh/${var.ssh_key.private_key_name}.pem"
//}