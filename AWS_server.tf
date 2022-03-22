provider "aws" {
  region = "us-west-2"
  shared_credentials_file = "/root/.aws/credentials"
  profile = "aws"
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
    public_key = ""
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
