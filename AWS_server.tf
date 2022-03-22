provider "aws" {
  region = "us-west-2"
  shared_credentials_file = "/root/.aws/credentials"
}
resource "aws_instance" "Ubuntu" {
  ami = "ami-074251216af698218"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.app.id}"]
  user_data = file("user_data.sh")
  key_name  = "id_rsa"
  tags = {
    Name = "Ubuntu_tomcat"
    Owner = "Stepan Sampara"
  }
}

resource "aws_instance" "Amazon_Linux" {
  ami = "ami-00ee4df451840fa9d"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.app.id}"]
  user_data = file("CentOS.sh")
  key_name  = "id_rsa"
  tags = {
    NAME = "CentOS_Postgre" 
    Owner = "Stepan Sampara"
  }
#  connection {
#     type        = "ssh"
#     host        = self.public_ip
#     user        = "ubuntu"
#     private_key = file("/home/step/.ssh/step_key")
#     timeout     = "4m"
#   }

}

   resource "aws_key_pair" "ssh-key" {
    key_name   = "id_rsa"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDcmQW1thpKV/6wZcTmVKx00MyrZeEaUWHAghzGVmZAJgI0ME+jQ7Fl+G/ySv1vKAixHbcndCjMlXz0ZLiS6O8Lnpfok5/h6YFs6cueFBtK+Ups3ykQgTNb1+s2KKSopCHDGQARvAXsp/KeIyyiNCmbRZFWv+q04Db4NM/CjKy6bp3ZmECVv/0PuLoN8NIUWkeDRsOXyO0U29WhCNcZTLWRazrrVIRUWLy41Sby4gsVtcv/NKxsoqpKCT+T1OGV1CmbOFg6Z4ScN/2SyZydgxZ3Ugw66JGbN+0VNyC0S2pkHJvRaIYL1lRYFp8QsG6c21qTMme8DIdSjjnZTnONn7DPKnuQ1cgtjFXNZo+EIUrrikjiYGyZVOC1pbEWYo5Wu/OB0/gW9N0HKTtDlfjJmMR+uu4YxoZRIMKcSpM9KzbAxKirBueCJ3AGboVfOZkwgCajiuAYMe7M6LXLSSjWjttZF4K8JR8Z84vfezP9ye54sHKbhzJn/sNC/yejD9hFGwE="
   }

resource "aws_security_group" "app" {
  name        = "allow_tls"
  
  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "Http-8080"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "PostgreSQL"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "icmp"
    from_port        = "-1"
    to_port          = "-1"
    protocol         = "icmp"
    cidr_blocks      = ["0.0.0.0/0"]
  }



  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
