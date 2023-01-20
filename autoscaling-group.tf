resource "aws_launch_template" "vault_server_launch_template" {
  name_prefix   = "vault-server"
  image_id      = var.ami
  instance_type = var.aws_instance_type

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 100
      volume_type = "gp3"
    }
  }
  network_interfaces {
    security_groups = [aws_security_group.sg-vault.id]
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.vault-kms-unseal.name
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name         = "cb-vault-test"
      billing_team = "discover-aws"
    }
  }
  user_data = "${base64encode(<<EOF
${templatefile("${path.module}/templates/vault.sh.tftpl", {
    region              = var.region
    dynamodb-table      = var.dynamodb-table
    unseal-key          = aws_kms_key.vault-unseal-key.id
    instance-role       = aws_iam_role.vault-kms-unseal.name
    vault_instance_role = "arn:aws:iam:${var.region}:${var.account_id}:role/${aws_iam_role.vault-kms-unseal.name}"
    vault_bucket        = var.bucket_name
    secret_token_id     = aws_secretsmanager_secret.vault-root-token.id
    secret_recovery_id  = aws_secretsmanager_secret.vault-recovery-key.id
})}
  EOF
)}"
}

resource "aws_autoscaling_group" "vault_server_autoscaling_group" {
  desired_capacity    = 3
  max_size            = 3
  min_size            = 3
  vpc_zone_identifier = var.private_subnet_ids
  target_group_arns   = [aws_lb_target_group.vault_target_group.arn]
  launch_template {
    id      = aws_launch_template.vault_server_launch_template.id
    version = "$Latest"
  }
  name       = "cb-vault-server"
  depends_on = [aws_kms_key.vault-unseal-key, aws_dynamodb_table.vault-table]
}
