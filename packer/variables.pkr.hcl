
variable "service_name" {
  type    = string
  default = "example"
}

variable "env" {
  type    = string
  default = "dev"
}

variable "skip_create_ami" {
  type    = bool
  default = false
}

variable "instance_type" {
  type    = string
  default = "t3.large"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "source_ami" {
  type    = string
  default = "ami-0c1a7f89451184c8b"
}

variable "ssh_username" {
  type    = string
  default = "ubuntu"
}
