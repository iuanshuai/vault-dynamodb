resource "aws_lb" "vault_alb" {
  name                       = "cb-vault-alb"
  internal                   = true
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.sg-vault.id]
  subnets                    = var.private_subnet_ids
  enable_deletion_protection = false

  tags = {
    billing_team = "discover-aws"
  }
}

resource "aws_lb_target_group" "vault_target_group" {
  name     = "cb-vault-target-group"
  port     = 8200
  protocol = "HTTP"
  vpc_id   = "vpc-07955ca50263477d3"
  health_check {
    path                = "/v1/sys/health"
    port                = 8200
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200,429"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.vault_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-east-1:932043579407:certificate/a4beb61a-664e-417d-8c38-460aead812f1"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.vault_target_group.arn
  }
}
