resource "aws_security_group" "AWSaccess" {
name = "terraform-19"
description = "SSH access"
ingress {
protocol = "tcp"
from_port = 22
to_port = 22
cidr_blocks = ["0.0.0.0/0"]
}
}
