
locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name        = "ami-${var.service_name}-${var.env}-${local.timestamp}"
  ami_description = "${var.service_name}-${var.env} AMI"
  skip_create_ami = "${var.skip_create_ami}"
  instance_type   = "${var.instance_type}"
  region          = "${var.region}"
  source_ami      = "${var.source_ami}"
  ssh_username    = "${var.ssh_username}"
  tags = {
    Name  = "${var.service_name}-${var.env}"
    Env   = "${var.env}"
  }
  run_tags = {
    Name  = "packer-${var.service_name}-${var.env}"
    Env   = "${var.env}"
  }
}

build {
  name = "Packer"

  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    script = "provision.sh"
  }

  provisioner "ansible-local" {
    playbook_file = "ansible/playbook.yml"
    playbook_dir  = "ansible"
    role_paths = [
      "ansible/roles"
    ]
    extra_arguments = [
      "-vv --skip-tags packer_ignore",
      "--extra-vars @host_vars/${var.env}.json"
    ]
  }

  post-processor "manifest" {
    output     = "manifest.json"
    strip_path = true
  }
}
