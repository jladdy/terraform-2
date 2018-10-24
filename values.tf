provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

variable "access_key" {}
variable "secret_key" {}
variable "key_name" {}
variable "chef_server_url" {}
variable "chef_server_user_name" {}
variable "chef_server_user_key" {}
variable "ssh_key_file" {}
variable "region" {}

variable "zone" {
  description = "Run the EC2 Instances in these Availability Zones"
  type = "list"
  default = [
              "us-east-1a",
              "us-east-1b",
              "us-east-1c",
              "us-east-1d",
              "us-east-1e",
              "us-east-1f"
              ]
}

variable "base" {
  default = "sg-abc123"
}

variable "ssh_user" {
    default = "ubuntu"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "root_device_type" {
    default = "gp2"
}

variable "root_device_size" {
    default = "16"
}

variable "ami" {
    default = "ami-0ac019f4fcb7cb7e6"
}

variable "num_servers" {
  default = 1
}

variable "example_com" {
  default = "ZONEID"
}
