
resource "aws_instance" "control_plane" {
  ami           = "ami-0d97d7f07b25dd693"
  instance_type = "t3.medium"

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.control_plane_sg.id]

  tags = {
    Name = "control-plane"
  }
}


resource "aws_instance" "worker_node_1" {
  ami           = "ami-0d97d7f07b25dd693"
  instance_type = "t3.medium"

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.worker_nodes_sg.id]

  tags = {
    Name = "worker-node-1"
  }
}


resource "aws_instance" "worker_node_2" {
  ami           = "ami-0d97d7f07b25dd693"
  instance_type = "t3.medium"

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.worker_nodes_sg.id]

  tags = {
    Name = "worker-node-2"
  }
}


