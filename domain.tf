# # Use existing hosted zone (does not create/destroy)
# data "aws_route53_zone" "main" {
#   name         = "dtootech.com"
#   private_zone = false
# }

# # Create/update A record to point to EC2 public IP
# resource "aws_route53_record" "a_record" {
#   zone_id = data.aws_route53_zone.main.zone_id

#   name    = "dtootech.com"                   # Root domain
#   type    = "A"
#   ttl     = 60
#   records = [aws_instance.Web_test[0].public_ip]  # Access first EC2
# }

# New Load balancer with Alias record 


# Reuse the existing Route 53 hosted zone
data "aws_route53_zone" "main" {
  name         = "dtootech.com"
  private_zone = false
}

# Remove or comment out the EC2 A record if switching to ALB
# resource "aws_route53_record" "a_record" { ... }

# Create alias record for ALB
resource "aws_route53_record" "a_record_alb" {
  zone_id = data.aws_route53_zone.main.zone_id

  name = "dtootech.com" # Use "www" if it's for www.dtootech.com
  type = "A"

  alias {
    name                   = aws_lb.web_alb.dns_name
    zone_id                = aws_lb.web_alb.zone_id
    evaluate_target_health = true
  }
}
