variable "private_subnet_cidrs" {
    description = "Private Subnet CIDR values"
    type = list(string)
    default = [ 
        "10.0.5.0/24",
        "10.0.6.0/24",
        "10.0.7.0/24",
        "10.0.8.0/24"
        ]
  
}