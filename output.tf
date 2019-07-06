output "user_name" {
  value = "${var.username}"
}

output "user_pass" {
  value = "${random_string.root_pass.result}"
}

output "nc-ip-address" {
  value = "${google_compute_instance.nc.network_interface.0.access_config.0.nat_ip}"
}

output "docs-ip-address" {
  value = "${google_compute_instance.docs.network_interface.0.access_config.0.nat_ip}"
}
