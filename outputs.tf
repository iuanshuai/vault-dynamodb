# Show how to authenticate to vault from the vault instance.
output "Authenticate_to_vault" {
  value = "vault login -method=aws role=admin"
}
output "lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = "${aws_lb.vault_alb.dns_name}"
}
# # Connect to Vault UI
# output "Connect_to_vault_UI" {
#   value = "http://${aws_instance.vault.private_ip}:8200"
# }
