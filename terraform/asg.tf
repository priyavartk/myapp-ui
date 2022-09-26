resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = "${var.service_name}-${var.env}-profile-${var.aws_region_short}"
  role = aws_iam_role.iam_role.name
}


resource "aws_iam_role" "iam_role" {
  name = "${var.service_name}-${var.env}-iam-role-${var.aws_region_short}"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_launch_template" "web" {
  name_prefix            = "web-${var.ami_id}"
  image_id               = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = ["${aws_security_group.web.id}"]
  key_name = var.key_name
  user_data = filebase64("script.sh")

  iam_instance_profile {
    arn = aws_iam_instance_profile.iam_instance_profile.arn
  }

  update_default_version = true

  tags = {
    Name = "${var.service_name}-${var.env}-web-lt-${var.aws_region}"
    Env  = "${var.env}"
  }
}


resource "aws_autoscaling_group" "web" {
  name                      = "${var.service_name}-${var.env}-web-asg-${var.aws_region_short}"
  vpc_zone_identifier       = var.vpc_zone_identifier
  max_size                  = var.max_size_for_web
  min_size                  = var.min_size_for_web
  target_group_arns         = ["${aws_alb_target_group.web.id}"]
  health_check_grace_period = var.health_check_grace_period

  launch_template {
    id      = aws_launch_template.web.id
    version = aws_launch_template.web.latest_version
  }

  instance_refresh {
    strategy = "Rolling"
  }

  tag {
    key                 = "Name"
    value               = "${var.service_name}-${var.env}-web-${var.aws_region_short}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Env"
    value               = var.env
    propagate_at_launch = true
  }

}

resource "aws_autoscaling_policy" "web-policy" {
  name                      = "${var.service_name}-${var.env}-web-asg-policy-${var.aws_region_short}"
  adjustment_type           = "ChangeInCapacity"
  policy_type               = "TargetTrackingScaling"
  autoscaling_group_name    = aws_autoscaling_group.web.name
  estimated_instance_warmup = 120
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60.0
  }
}
