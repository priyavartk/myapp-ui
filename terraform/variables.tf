variable "aws_region" {
  description = "AWS Region Name"
  type        = string
  default     = "us-west-1"
}

variable "aws_region_short" {
  description = "AWS Region Short Name"
  type        = string
  default     = "usea1"
}


variable "vpc_id" {
  description = "VPC Id"
  type        = string
}

variable "service_name" {
  description = "Service Name"
  type        = string
  default     = "example"
}

variable "env" {
  description = "Enviornment Name"
  type        = string
  default     = "dev"
}

variable "backend_port" {
  description = "port number of backend service"
  type        = string
  default     = "80"
}

variable "public_cidr" {
  description = "Public CIDR"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ami_id" {
  description = "AMI to deploy"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the instance"
  default     = "t3.large"
}

variable "max_size_for_web" {
  description = "Max number of instances"
  type        = string
  default     = "3"
}

variable "min_size_for_web" {
  description = "Min number of instances"
  type        = string
  default     = "1"
}

variable "health_check_grace_period" {
  description = "Health Check Grace Period"
  type        = string
  default     = "30"
}


variable "vpc_zone_identifier" {
  description = "VPC Zone Identifier"
  type        = list(string)
}

variable "subnets" {
  description = "Subnets for the instance"
  type        = list(string)
}

variable "ssh_port" {
  description = "ssh port number"
  type        = string
  default     = "22"
}

variable "http_port" {
  description = "HTTP Port"
  type        = string
  default     = "80"
}

variable "health_check_endpoint" {
  description = "Health Check Endpoint"
  type        = string
  default     = "/"
}
variable "key_name" {
   description ="ssh key name"
   type = string
}
