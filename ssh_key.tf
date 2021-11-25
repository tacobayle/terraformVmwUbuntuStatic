
resource "tls_private_key" "ssh" {
  algorithm = var.ssh_key.algorithm
  rsa_bits  = var.ssh_key.rsa_bits
}

resource "random_string" "private_key_file_name" {
  length           = 8
  special          = true
  min_lower        = 8
}

resource "local_file" "private_key" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = pathexpand("~/.ssh/${var.ssh_key.private_key_basename}${random_string.private_key_file_name.result}.pem")
  file_permission = var.ssh_key.file_permission
}