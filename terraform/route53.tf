resource "aws_route53_record" "web" {
  zone_id = var.hosted_zone_id
  name    = "${var.service_name}-web-${var.env}"
  type    = var.hosted_zone_type
  ttl     = "300"

  records = ["${aws_alb.web.dns_name}"]
}
