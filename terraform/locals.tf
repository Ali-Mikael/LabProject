locals {

  common_tags = {
    Project   = "CI/CD-platform"
    Creator   = "Ali-G"
    ManagedBy = "Terraform"
  }

  # Ports to be used in NACL and SGs etc.
  port = {
    http            = 80
    https           = 443
    ssh             = 22
    ephemeral_start = 1024
    ephemeral_end   = 65535
  }


  # NACL rules
  nacl_rules = {

    public = {
      ingress = [
        { rule_no = 100, protocol = "tcp", rule_action = "allow", cidr_block = "0.0.0.0/0", from_port = local.port.http, to_port = local.port.http, description = "Allow HTTP" },
        { rule_no = 110, protocol = "tcp", rule_action = "allow", cidr_block = "0.0.0.0/0", from_port = local.port.https, to_port = local.port.https, description = "Allow HTTPS" },
        { rule_no = 120, protocol = "tcp", rule_action = "allow", cidr_block = "0.0.0.0/0", from_port = local.port.ssh, to_port = local.port.ssh, description = "Allow SSH" }
      ]
      egress = [
        { rule_no = 100, protocol = "-1", rule_action = "allow", cidr_block = var.main_cidr, from_port = 0, to_port = 0, description = "Allow all outbound" }
      ]
    }

    private = {
      ingress = [
        { rule_no = 100, protocol = "tcp", rule_action = "allow", cidr_block = var.public_subnets["main"].cidr, from_port = local.port.http, to_port = local.port.http, description = "Allow HTTP from public subnet" },
        { rule_no = 110, protocol = "tcp", rule_action = "allow", cidr_block = var.public_subnets["main"].cidr, from_port = local.port.https, to_port = local.port.https, description = "Allow HTTS from public subnet" },
        { rule_no = 120, protocol = "tcp", rule_action = "allow", cidr_block = var.public_subnets["main"].cidr, from_port = local.port.http, to_port = local.port.http, description = "Allow SSH from public subnet" },
      ]

      egress = [
        { rule_no = 100, protocol = "-1", rule_action = "allow", cidr_block = var.main_cidr, from_port = 0, to_port = 0, description = "Allow all outgoing traffic from private subnets" }
      ]
    }
    


  }
}