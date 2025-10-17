# --------
# NACLs
# --------

# Define NACL
resource "aws_network_acl" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "Public-Subnet-NACL"
  })
}

resource "aws_network_acl" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "Private-Subnet-NACL"
  })
}


# ---------------------------
# NACL rules
# (check locals.tf for config)
# ---------------------------

# Public NACL rule creation
resource "aws_network_acl_rule" "public_ingress" {
  for_each = { for rule in local.nacl_rules.public.ingress : rule.rule_no => rule }

  
  network_acl_id = aws_network_acl.public.id
  rule_number    = each.value.rule_no
  egress         = false
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}


resource "aws_network_acl_rule" "public_egress" {
  for_each = { for rule in local.nacl_rules.public.egress : rule.rule_no => rule }

  network_acl_id = aws_network_acl.public.id
  rule_number    = each.value.rule_no
  egress         = true
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}


# Private NACL rule creation
resource "aws_network_acl_rule" "private_ingress" {
  for_each = { for rule in local.nacl_rules.private.ingress : rule.rule_no => rule }

  network_acl_id = aws_network_acl.private.id
  rule_number    = each.value.rule_no
  egress         = false
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port

}

resource "aws_network_acl_rule" "private_egress" {
  for_each = { for rule in local.nacl_rules.private.egress : rule.rule_no => rule }

  network_acl_id = aws_network_acl.private.id
  rule_number    = each.value.rule_no
  egress         = true
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}



# Associations
resource "aws_network_acl_association" "public_subnet" {
  for_each = aws_subnet.public_subnets

  subnet_id      = each.value.id
  network_acl_id = aws_network_acl.public.id
}

resource "aws_network_acl_association" "private_subnet" {
  for_each = aws_subnet.private_subnets

  subnet_id      = each.value.id
  network_acl_id = aws_network_acl.private.id
}

