variable "region" {
  type    = string
  default = "us-east-1"
}

variable "account_id" {
  description = "AWS Account ID - REMOVE BEFORE PUBLISHING"
  type        = string
  default     = "932043579407"
}

variable "my_ip" {
  description = "my external IP address"
  type        = string
  default     = "172.26.0.0/16"
}

variable "ami" {
  description = "Amazon Linux 2 AMI"
  type        = string
  default     = "ami-026b57f3c383c2eec"
}

variable "aws_instance_type" {
  description = "aws instance type"
  type        = string
  default     = "m5.large"
}

# Size of the OS volume
variable "root_volume_size" {
  description = "size of the os volume in GB"
  type        = string
  default     = "100"
}

# May need to change the bucket to something unique
variable "bucket_name" {
  description = "Bucket to upload any required files"
  type        = string
  default     = "cb-vault-test-s3"
}


variable "private-subnet" {
  description = "Private CIDR"
  default     = "10.0.2.0/24"
}

variable "dynamodb-table" {
  description = "DynamoDB table name"
  type        = string
  default     = "vault-table"
}

variable "dynamo-read-write" {
  description = "Read / Write value"
  default     = 50
}

variable "vault-root-token" {
  description = "Name of the secrets manager secret to save the vault root token to"
  default     = "vault-root-token"
}

variable "vault-recovery-key" {
  description = "Name of the secrets manager secret to save the vault recovery key to"
  default     = "vault-recovery-key"
}

variable "instance-role" {
  description = "The instance role"
  default     = "cb-vault-role-test"
}

variable "instance-role-policy" {
  description = "The policy"
  default     = "vault-role-policy"
}

variable "instance-profile" {
  description = "The profile"
  default     = "vault-instance-profile"
}

variable "ingress-rules" {
  description = "Allow SSH and Vault Port inbound"
  type        = list(number)
  default     = [22, 8200]
}

variable "egress-rules" {
  description = "Allow HTTP and HTTPS outbound"
  type        = list(number)
  default     = [80, 443]
}

variable "private_subnet_ids" {
  type = list(string)
  default = [
    "subnet-018598343b8c7e12f", # cb-main-dev-us-vpc-private-subnet-a1
    "subnet-09982e19e022e9c04", # cb-main-dev-us-vpc-private-subnet-b1
    "subnet-0f99410c0083708db"  # cb-main-dev-us-vpc-private-subnet-c1
  ]
}
