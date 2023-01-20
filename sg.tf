resource "aws_security_group" "sg-vault" {
  name   = "cb-vault-test-sg"
  vpc_id = "vpc-07955ca50263477d3"

  ingress {
    description = "FROM VPN"
    from_port   = 8200
    to_port     = 8200
    protocol    = "tcp"
    cidr_blocks = ["172.26.0.0/16"]
  }

  ingress {
    description = "FROM VPC"
    from_port   = 8200
    to_port     = 8201
    protocol    = "tcp"
    cidr_blocks = ["172.18.0.0/16"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["172.26.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name         = "cb-vault-test-sg"
    billing_team = "discover-aws"
  }
}