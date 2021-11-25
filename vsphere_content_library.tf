
resource "null_resource" "download_ubuntu" {
  provisioner "local-exec" {
    command = "curl -o /tmp/$(basename ${var.content_library.source_url}) ${var.content_library.source_url}"
  }
}

resource "random_string" "content_library_name" {
  length           = 6
  special          = true
  min_lower        = 6
}

resource "vsphere_content_library" "library" {
  name            = "${var.content_library.basename}-${random_string.content_library_name.result}"
  storage_backing = [data.vsphere_datastore.datastore.id]
  description     = var.content_library.description
}

resource "vsphere_content_library_item" "file" {
  depends_on = [null_resource.download_ubuntu]
  name        = basename(var.content_library.source_url)
  library_id  = vsphere_content_library.library.id
  file_url = "/tmp/${basename(var.content_library.source_url)}"
}