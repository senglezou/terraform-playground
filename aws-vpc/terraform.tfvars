# Skip 10.0.3.0/24 as the reserved space for a fourth AZ public subnet
# Skip 10.0.7.0/24 as the reserved space for a fourth AZ private subnet
# Skip 10.0.11.0/24 as the reserved space for a fourth AZ internal subnet
subnet_data = {
    publicAsubnet = {
        cidr_block = "10.0.0.0/24"
        availability_zone = "eu-west-1a" # todo: make dynamic
        public_ip_on_launch = true
    },
    publicBsubnet = {
        cidr_block = "10.0.1.0/24"
        availability_zone = "eu-west-1b" # todo: make dynamic
        public_ip_on_launch = true
    },
    publicCsubnet = {
        cidr_block = "10.0.2.0/24"
        availability_zone = "eu-west-1c" # todo: make dynamic
        public_ip_on_launch = true
    },
    privateAsubnet = {
        cidr_block = "10.0.4.0/24"
        availability_zone = "eu-west-1a" # todo: make dynamic
        public_ip_on_launch = false
    },
    privateBsubnet = {
        cidr_block = "10.0.5.0/24"
        availability_zone = "eu-west-1b" # todo: make dynamic
        public_ip_on_launch = false
    },
    privateCsubnet = {
        cidr_block = "10.0.6.0/24"
        availability_zone = "eu-west-1c" # todo: make dynamic
        public_ip_on_launch = false
    },
    internalAsubnet = {
        cidr_block = "10.0.8.0/24"
        availability_zone = "eu-west-1a" # todo: make dynamic
        public_ip_on_launch = false
    },
    internalBsubnet = {
        cidr_block = "10.0.9.0/24"
        availability_zone = "eu-west-1b" # todo: make dynamic
        public_ip_on_launch = false
    },
    internalCsubnet = {
        cidr_block = "10.0.10.0/24"
        availability_zone = "eu-west-1c" # todo: make dynamic
        public_ip_on_launch = false
    },
}