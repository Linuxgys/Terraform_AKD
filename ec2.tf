resource "aws_instance" "Web_test" {
  ami                         = "ami-0bdea0bb64cf0f044"
  instance_type               = "t2.micro"
  count                       = 1
  subnet_id                   = aws_subnet.public_subnet1.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  key_name                    = "terraform"

  user_data = <<EOF
#!/bin/bash
set -euxo pipefail

sleep 30
apt update -y
DEBIAN_FRONTEND=noninteractive apt install -y nginx wget

# Download image
wget -O /var/www/html/image.webp "https://as2.ftcdn.net/jpg/13/69/17/91/1000_F_1369179137_MOutjHbnoLoRzJvtCF2gsMMXU9YWlN8q.webp"

# Create HTML
cat <<'EOT' > /var/www/html/index.html
<html>
<head><title>Jai Bajarang Bali</title></head>
<body>
<h1 style="color: orange; font-weight: bold;">🚩 जय श्री राम 🚩</h1>
<img src="image.webp" width="600"/>
</body>
</html>
EOT

# Update Nginx config
cat <<'EOT' > /etc/nginx/sites-available/default
server {
    listen 80;
    server_name dtootech.com www.dtootech.com;

    root /var/www/html;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location = /health {
        access_log off;
        return 200 'OK';
        add_header Content-Type text/plain;
    }
}
EOT

echo "OK" > /var/www/html/health
chmod 644 /var/www/html/health

systemctl restart nginx
EOF

  tags = {
    Name = "Web-${count.index + 1}"
    OS   = "Ubuntu"
    Env  = "Dev"
  }
}
