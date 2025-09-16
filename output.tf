output "web_instances_info" {
  description = "Public IP and DNS of all EC2 Web instances"
  value = [
    for instance in aws_instance.Web_test : {
      public_ip  = instance.public_ip
      public_dns = instance.public_dns
      private_ip = instance.private_ip
      subnet_id  = instance.subnet_id
    }
  ]
}
output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "subnet_id" {
  value = aws_subnet.main_subnet.id
}

output "security_group_id" {
  value = aws_security_group.web_sg.id
}