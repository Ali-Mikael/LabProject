output "vpc_id" {
  description = "ID of the main VPC"
  value       = aws_vpc.main.id
}

###################################
# Public Subnets
###################################
output "public_subnet_ids" {
  description = "IDs of all public subnets"
  value       = [for s in aws_subnet.public : s.id]
}

output "public_subnet_cidrs" {
  description = "CIDR blocks of all public subnets"
  value       = [for s in aws_subnet.public : s.cidr_block]
}

output "public_subnet_azs" {
  description = "Availability Zones of all public subnets"
  value       = [for s in aws_subnet.public : s.availability_zone]
}

###################################
# Private Subnets
###################################
output "private_subnet_ids" {
  description = "IDs of all private subnets"
  value       = [for s in aws_subnet.private_subnets : s.id]
}

output "private_subnet_cidrs" {
  description = "CIDR blocks of all private subnets"
  value       = [for s in aws_subnet.private_subnets : s.cidr_block]
}

output "private_subnet_azs" {
  description = "Availability Zones of all private subnets"
  value       = [for s in aws_subnet.private_subnets : s.availability_zone]
}