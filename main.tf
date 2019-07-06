resource "random_string" "root_pass" {
  length    = "${var.length_pass}"
  special   = false
  min_upper = 2
  min_lower = 2
}
