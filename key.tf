resource "aws_key_pair" "terraform-19" {
key_name = "terraform-19"
public_key = "${file("C:\\Users\\sfjbs\\.ssh\\id_rsa.pub")}"
}
