resource "aws_alb_target_group" "web" {
  name     = "${var.service_name}-web-tg-${var.env}-${var.aws_region_short}"
  port     = var.backend_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.selected.id
  health_check {
    path = var.health_check_endpoint
  }
}

resource "aws_alb" "web" {
  name               = "web-alb-${var.env}-${var.aws_region_short}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public.id]
  subnets            = var.subnets

  enable_deletion_protection = true

  tags = {
    Name = "web-alb-${var.env}-${var.aws_region_short}"
    Env  = "${var.env}"
  }
}

resource "aws_alb_listener" "web" {
  load_balancer_arn = aws_alb.web.arn
  port              = var.https_port
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.web.arn
  }
}
