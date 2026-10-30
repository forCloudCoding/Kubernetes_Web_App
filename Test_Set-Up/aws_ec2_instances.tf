
resource "aws_instance" "server_1" {
  ami           = "ami-0d97d7f07b25dd693"
  instance_type = "t3.medium"

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.server_1_sg.id]

  tags = {
    Name = "server_1"
  }
}


resource "aws_instance" "client_1" {
  ami           = "ami-0d97d7f07b25dd693"
  instance_type = "t3.medium"

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.client_1_sg.id]

  tags = {
    Name = "client_1"
  }
}

