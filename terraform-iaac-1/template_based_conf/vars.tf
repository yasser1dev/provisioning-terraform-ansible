variable "public_ip" {}
variable "public_dns" {}
variable "private_key_filename" {}
variable "absolute_path_tmpl_file" {
  default = "~/self-provisioning/terraform-iaac-1/template_based_conf"
}
