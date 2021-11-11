output "jump" {
  value = vsphere_virtual_machine.ubuntu.default_ip_address
}

output "ssh_private_key_path" {
  value = "~/.ssh/${var.ssh_key.private_key_basename}.pem"
}