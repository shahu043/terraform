provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "web" {
  ami           = "ami-09ba48996007c8b50"
  instance_type = "t2.micro"
  availability_zone = "ap-south-1a"
  key_name      = aws_key_pair.terraform-19.key_name

  tags = {
    Name = "terraform-19"
  }
/*
  provisioner "local-exec" {
    command = "echo ${aws_instance.web.private_ip} > ip_address.txt"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras enable nginx1.12",
      "sudo yum -y install nginx",
      "sudo systemctl start nginx",
    ]
  }
*/
  depends_on      = [aws_ebs_volume.terraform-19]
  security_groups = ["${aws_security_group.AWSaccess.name}"]
}

resource "aws_ebs_volume" "terraform-19" {
  availability_zone = "ap-south-1a"
  size              = 10

  tags = {
    Name = "terraform-19"
  }
}
resource "aws_volume_attachment" "ebs_add" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.terraform-19.id
  instance_id = aws_instance.web.id
}

resource "aws_eip" "terraform-19" {
  instance = aws_instance.web.id
  vpc      = true

  tags = {
    Name = "terraform-19"
  }
}


output "ip" {
  value = aws_instance.web.public_ip
}



