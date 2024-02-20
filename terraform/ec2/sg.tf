resource "aws_security_group" "project-iac-sg" {
  name = "iac-test-node"
  description = "iac-test-node"
  vpc_id = var.vpcid

  tags = merge(var.tags,
    {
      Name = "otf-terraform-group"
    }

  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  // To Allow Port 80 Transport
  ingress {
    from_port = 80
    protocol = ""
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
