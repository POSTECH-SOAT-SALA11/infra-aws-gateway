resource "aws_acm_certificate" "avalanches_cert" {
  provider = aws.us_east
  domain_name       = "avalanches.com"  
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_zone" "avalanches_router53" {
  name = "avalanches.com"  
}

resource "aws_route53_record" "cert_validation" {
  for_each = { for dvo in aws_acm_certificate.avalanches_cert.domain_validation_options : dvo.resource_record_name => dvo }

  zone_id = aws_route53_zone.avalanches_router53.zone_id
  name     = each.key
  type     = each.value.resource_record_type
  ttl      = 60
  records  = [each.value.resource_record_value]
}
