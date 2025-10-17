locals {

  common_tags = {
    Project   = "CI/CD-platform"
    ManagedBy = "Terraform"
    creator   = "Ali-G"
  }

  port = {
    http            = 80
    https           = 443
    ssh             = 22
    ephemeral_start = 1024
    ephemeral_end   = 65535
  }
}
