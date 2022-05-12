resource "aws_instance" "EC2-public-subnet-1A" {
    ami = "ami-0c02fb55956c7d316"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public-subnet1.id
    associate_public_ip_address = true
    vpc_security_group_ids = [ aws_security_group.SG-1A.id ]
    key_name = aws_key_pair.personal_key.key_name
    availability_zone = "us-east-1a"
    depends_on = [
      aws_internet_gateway.internet-gateway
    ]
    tags = {
      Name = "Public-1A"
    }
}
resource "aws_instance" "EC2-public-subnet-1B" {
    ami = "ami-0c02fb55956c7d316"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public-subnet2.id
    associate_public_ip_address = true
    vpc_security_group_ids = [ aws_security_group.SG-1B.id ]
    key_name = aws_key_pair.personal_key.key_name
    availability_zone = "us-east-1b"
    depends_on = [
      aws_internet_gateway.internet-gateway
    ]
    tags = {
      Name = "Public-1B"
    }
}
resource "aws_instance" "EC2-private-subnet-1A" {
    ami = "ami-0c02fb55956c7d316"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.private-subnet1.id
    associate_public_ip_address = false
    vpc_security_group_ids = [ aws_security_group.SG-private-1A.id ]
    key_name = aws_key_pair.personal_key.key_name
    availability_zone = "us-east-1a"
    depends_on = [
      aws_internet_gateway.internet-gateway
    ]
    tags = {
      Name = "Private-1A"
    }
}
resource "aws_instance" "EC2-private-subnet-1B" {
    ami = "ami-0c02fb55956c7d316"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.private-subnet2.id
    associate_public_ip_address = false
    vpc_security_group_ids = [ aws_security_group.SG-private-1B.id ]
    key_name = aws_key_pair.personal_key.key_name
    availability_zone = "us-east-1b"
    depends_on = [
      aws_internet_gateway.internet-gateway
    ]
    tags = {
      Name = "Private-1B"
    }
}
resource "aws_security_group" "SG-1A" {
    vpc_id = aws_vpc.vpc.id
    egress = [ {
      cidr_blocks = [ "0.0.0.0/0" ]
      description = ""
      from_port = 0
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      protocol = "-1"
      security_groups = []
      self = false
      to_port = 0
    } ]
    
    ingress = [ {
      cidr_blocks = [ "0.0.0.0/0" ]
      description = ""
      from_port = 22
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      protocol = "tcp"
      security_groups = []
      self = false
      to_port = 22
    } ]
}
resource "aws_security_group" "SG-1B" {
    vpc_id = aws_vpc.vpc.id
    egress = [ {
      cidr_blocks = [ "0.0.0.0/0" ]
      description = ""
      from_port = 0
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      protocol = "-1"
      security_groups = []
      self = false
      to_port = 0
    } ]
    ingress = [ {
      cidr_blocks = [ "0.0.0.0/0" ]
      description = ""
      from_port = 22
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      protocol = "tcp"
      security_groups = []
      self = false
      to_port = 22
    } ]
}
resource "aws_security_group" "SG-private-1A" {
    vpc_id = aws_vpc.vpc.id
    egress = [ {
        cidr_blocks = [ "0.0.0.0/0" ]
        description = ""
        from_port = "-1"
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        protocol = "icmp"
        security_groups = []
        self = false
        to_port = "-1"
    } ] 
    ingress = [ {
        cidr_blocks = [ "192.168.0.0/16" ]
        description = ""
        from_port = "-1"
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        protocol = "icmp"
        security_groups = []
        self = false
        to_port = "-1"
    },
    {
        cidr_blocks = [ "192.168.0.0/16" ]
        description = "SSH from bastion host"
        from_port = 22
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        protocol = "tcp"
        security_groups = []
        self = false
        to_port = 22
    } ]
}
resource "aws_security_group" "SG-private-1B" {
    vpc_id = aws_vpc.vpc.id
    egress = [ {
      cidr_blocks = [ "0.0.0.0/0" ]
      description = ""
      from_port = "-1"
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      protocol = "icmp"
      security_groups = []
      self = false
      to_port = "-1"
    } ]
    ingress = [ {
        cidr_blocks = [ "192.168.0.0/16" ]
        description = ""
        from_port = "-1"
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        protocol = "icmp"
        security_groups = []
        self = false
        to_port = "-1"
    },
    {
        cidr_blocks = [ "192.168.0.0/16" ]
        description = "SSH from bastion host"
        from_port = 22
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        protocol = "tcp"
        security_groups = []
        self = false
        to_port = 22
    } ]
}
resource "aws_key_pair" "personal_key" {
  key_name   = "aws_key"
  public_key = "SSH_PUB_KEY_HERE"
    tags = {
        "Name" = "SSH-Key"
    }
}
