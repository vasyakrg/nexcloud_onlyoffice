#===============================================
# Create onlyoffice server
#===============================================
resource "google_compute_instance" "docs" {
  name         = "onlyoffice-app"
  machine_type = "${var.docs_machine_type}"
  zone         = "${var.zone_instance}"
  tags         = ["${var.net_tag_docs}"]

  # add image disk
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  # add network
  network_interface {
    network = "${var.network_name}"
    access_config {
    }
  }
  # ssh_key
  metadata = {
    sshKeys = "${var.username}:${file("~/.ssh/id_rsa.pub")}"
  }

  metadata_startup_script = "${file("scripts/docs-preinstall.sh")}"

  connection {
    host        = "${self.network_interface.0.access_config.0.nat_ip}"
    type        = "ssh"
    user        = "${var.username}"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo '${var.username}:${random_string.root_pass.result}' | sudo chpasswd",
      "sudo usermod -aG sudo ${var.username}",
    ]
  }

  provisioner "file" {
    source      = "scripts/docs-install.sh"
    destination = "/home/${var.username}/docs-install.sh"
  }

  provisioner "file" {
    source      = "scripts/ds.conf"
    destination = "/tmp/ds.conf"
  }

  provisioner "file" {
    source      = "scripts/ds.new.conf"
    destination = "/tmp/ds.new.conf"
  }

  provisioner "local-exec" {
    command = "echo '#==========#\ndocs_ip=${self.network_interface.0.access_config.0.nat_ip}\nlogin=${var.username}\npassword=${random_string.root_pass.result}' >> host"
  }
}
