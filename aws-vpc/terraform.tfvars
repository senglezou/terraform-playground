# Skip 10.0.3.0/24 as the reserved space for a fourth AZ public subnet
# Skip 10.0.7.0/24 as the reserved space for a fourth AZ private subnet
# Skip 10.0.11.0/24 as the reserved space for a fourth AZ internal subnet
subnet_data = {
    publicAsubnet = {
        cidr_block = "10.0.0.0/24"
        availability_zone = "eu-west-1a" # todo: make dynamic
        public_ip_on_launch = true
        associate_public_subnets_to_route_table = true
    },
    publicBsubnet = {
        cidr_block = "10.0.1.0/24"
        availability_zone = "eu-west-1b" # todo: make dynamic
        public_ip_on_launch = true
        associate_public_subnets_to_route_table = true
    },
    publicCsubnet = {
        cidr_block = "10.0.2.0/24"
        availability_zone = "eu-west-1c" # todo: make dynamic
        public_ip_on_launch = true
        associate_public_subnets_to_route_table = true
    },
    privateAsubnet = {
        cidr_block = "10.0.4.0/24"
        availability_zone = "eu-west-1a" # todo: make dynamic
        public_ip_on_launch = false
        associate_public_subnets_to_route_table = false
    },
    privateBsubnet = {
        cidr_block = "10.0.5.0/24"
        availability_zone = "eu-west-1b" # todo: make dynamic
        public_ip_on_launch = false
        associate_public_subnets_to_route_table = false
    },
    privateCsubnet = {
        cidr_block = "10.0.6.0/24"
        availability_zone = "eu-west-1c" # todo: make dynamic
        public_ip_on_launch = false
        associate_public_subnets_to_route_table = false
    },
    internalAsubnet = {
        cidr_block = "10.0.8.0/24"
        availability_zone = "eu-west-1a" # todo: make dynamic
        public_ip_on_launch = false
        associate_public_subnets_to_route_table = false
    },
    internalBsubnet = {
        cidr_block = "10.0.9.0/24"
        availability_zone = "eu-west-1b" # todo: make dynamic
        public_ip_on_launch = false
        associate_public_subnets_to_route_table = false
    },
    internalCsubnet = {
        cidr_block = "10.0.10.0/24"
        availability_zone = "eu-west-1c" # todo: make dynamic
        public_ip_on_launch = false
        associate_public_subnets_to_route_table = false
    },
}