variable "aws_base_ami_id" {
  type    = string
  default = "ami-0932440befd74cdba"
}

variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "aws_access_key_id" {
  type    = string
  default = ""
}

variable "aws_secret_access_key" {
  type      = string
  default   = ""
  sensitive = true
}

source "amazon-ebs" "aws" {
  access_key    = var.aws_access_key_id
  ami_name      = "ubuntu-nginx64-${formatdate("YYYYMMDD", timestamp())}"
  instance_type = "t2.micro"
  region        = var.aws_region
  secret_key    = var.aws_secret_access_key
  source_ami    = var.aws_base_ami_id
  ssh_username  = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.aws"]

  provisioner "shell" {
    inline = ["while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done"]
  }
  
  provisioner "shell" {
    script = "scripts/install_nginx.sh"
  }
}
