#===============================================
# Create firefall for nextcloud
#===============================================
resource "google_compute_firewall" "allow-ports-nc" {
  name = "allow-posts-nc"

  # name of net
  network = "default"

  allow {
    protocol = "tcp"
    ports = [
      "443",
      "80",
      "22",
      "19999"
    ]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["${var.net_tag_nc}"]
}

#===============================================
# Create firefall for docs
#===============================================
resource "google_compute_firewall" "allow-ports-docs" {
  name = "allow-ports-docs"

  # name of net
  network = "default"

  allow {
    protocol = "tcp"
    ports = [
      "22",
      "80",
      "443"
    ]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["${var.net_tag_docs}"]
}

#===============================================
# Create A records to AWS
#===============================================
data "aws_route53_zone" "dns_zone" {
  name = "${var.dns_zone_name}"
}

resource "aws_route53_record" "nc" {
  zone_id = "${data.aws_route53_zone.dns_zone.id}"
  name    = "${var.name_virtualhost[0]}"
  type    = "A"
  ttl     = "300"
  records = ["${google_compute_instance.nc.network_interface.0.access_config.0.nat_ip}"]
}

resource "aws_route53_record" "docs" {
  zone_id = "${data.aws_route53_zone.dns_zone.id}"
  name    = "${var.name_virtualhost[1]}"
  type    = "A"
  ttl     = "300"
  records = ["${google_compute_instance.docs.network_interface.0.access_config.0.nat_ip}"]
}
