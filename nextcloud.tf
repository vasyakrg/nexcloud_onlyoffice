#===============================================
# Create nextcloud server
#===============================================
resource "google_compute_instance" "nc" {
  name         = "nextcloud-app"
  machine_type = "${var.nc_machine_type}"
  zone         = "${var.zone_instance}"
  tags         = ["${var.net_tag_nc}"]

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

  metadata_startup_script = "${file("scripts/nc-preinstall.sh")}"

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
      "cd /home/${var.username}",
      "wget https://raw.githubusercontent.com/nextcloud/vm/master/nextcloud_install_production.sh"
    ]
  }

  provisioner "local-exec" {
    command = "echo '#==========#\nnextcloud_ip=${self.network_interface.0.access_config.0.nat_ip}\nlogin=${var.username}\npassword=${random_string.root_pass.result}' >> host"
  }
  provisioner "local-exec" {
    command = "rm -rf host"
    when    = "destroy"
  }
}
