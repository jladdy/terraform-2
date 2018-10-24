resource "aws_instance" "provisioning_server" {
      count = "${var.num_servers}"
      ami = "${var.ami}"
      instance_type     = "${var.instance_type}"
      availability_zone = "${element(var.zone, count.index)}"
      vpc_security_group_ids = ["${var.base}"]
      key_name          = "${var.key_name}"
      tags {
        Name = "prov${count.index}"
          App =  "Management"
          Role = "Provisioning Server"
          }
          root_block_device {
    volume_type = "${var.root_device_type}"
    volume_size = "${var.root_device_size}"
    delete_on_termination = "true"
    }
  provisioner "chef"  {
      connection {
          host = "${self.public_ip}"
          type = "ssh"
          user = "${var.ssh_user}"
          private_key = "${file(var.ssh_key_file)}"
      }
      environment = "production"
      run_list = ["role[base]", "role[dev]", "role[network]", "role[terraform]", "role[ansible]"]
      node_name = "prov${count.index}"
      server_url = "${var.chef_server_url}"
      recreate_client = true
      user_name = "${var.chef_server_user_name}"
      user_key = "${file(var.chef_server_user_key)}"
      fetch_chef_certificates = true
  }
}

resource "aws_route53_record" "provisioning_server_public" {
  count = "${var.num_servers}"
  zone_id = "${var.example_com}"
  name = "prov${count.index}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.provisioning_server.*.public_ip, count.index)}"]
}
