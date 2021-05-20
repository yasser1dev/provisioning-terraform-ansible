resource "local_file" "ansible_inventory" {
  content = templatefile("${var.absolute_path_tmpl_file}/inventory.tmpl", {
      ip          = var.public_ip,
      ssh_keyfile = var.private_key_filename
  })
  filename = format("%s/%s", abspath(path.root), "inventory.yaml")
}

resource "local_file" "ssl_subject_alt_ip" {
  content = templatefile("${var.absolute_path_tmpl_file}/main.tmpl", {
      ip          = var.public_ip
  })
  filename = format("%s/%s",abspath(path.root),"main.yml")
}
   

resource "local_file" "conf_server_name" {
  content = templatefile("${var.absolute_path_tmpl_file}/web-site1.tmpl", {
     public_dns          = var.public_dns
  })
  filename = format("%s/%s",abspath(path.root),"web-site1")
}
