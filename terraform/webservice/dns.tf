resource "aws_route53_record" "www" {
  zone_id = var.route53_zone_id
  name    = var.environment_name
  type    = "A"

  alias {
    name                   = aws_lb.front_end.dns_name
    zone_id                = aws_lb.front_end.zone_id
    evaluate_target_health = true
  }
}

/*resource "aws_route53_record" "service_route" {
  zone_id = var.route53_zone_id
  name = var.domain
  type = "CNAME"
  ttl = "300"
  records = [aws_lb.front_end.dns_name]
}*/
