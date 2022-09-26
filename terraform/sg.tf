resource "aws_security_group" "web" {
  name_prefix = "${var.service_name}-sg-${var.aws_region}-${var.env}"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
#    cidr_blocks = ["${data.aws_vpc.selected.cidr_block}"]
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.backend_port
    to_port     = var.backend_port
    protocol    = "tcp"
#    cidr_blocks = ["${data.aws_vpc.selected.cidr_block}"]
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0  # all ports
    to_port     = 0  # all ports
    protocol    = -1 # all protocols
    cidr_blocks = ["${var.public_cidr}"]
  }

  tags = {
    Name = "${var.service_name}-sg-${var.env}-${var.aws_region}"
    Env  = "${var.env}"
  }
}


resource "aws_security_group" "public" {
  name_prefix = "public-sg-${var.aws_region}-${var.env}"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["${var.public_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["${var.public_cidr}"]
  }

  tags = {
    Name = "public-sg-${var.env}-${var.aws_region}"
    Env  = "${var.env}"
  }
}
