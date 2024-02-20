resource "aws_instance" "project-iac" {
  ami = "ami-05d47d29a4c2d19e1"
  instance_type = "t2.large"
  subnet_id = var.subnet_id
  associate_public_ip_address = true
  key_name = "Shahid-eda-key"
  vpc_security_group_ids = [ aws_security_group.project-iac-sg.id ]

  root_block_device {
    delete_on_termination = true
    volume_size = 50
    volume_type = "gp2"
  }
  tags = merge(var.tags,
    {
      Name = "otf-terraform-group"
    }
    )
  }





