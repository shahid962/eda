#Security group for public subnet resources
resource "aws_security_group" "public_sg" {
  name   = "public_sg"
  vpc_id = aws_vpc.vpc.id
  tags = merge(var.tags,
    {
      Name = "Shahid-eda-public-sg"
    }
  )

}

#Security group traffic rules
##Ingress Rules
#Allow https traffic 
resource "aws_security_group_rule" "https_in" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public_sg.id
}

#Allow http traffic 
resource "aws_security_group_rule" "http_in" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public_sg.id

}

#Egress Rules
#Allow all traffic
resource "aws_security_group_rule" "all_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public_sg.id
}

#Rule for dataplane 
resource "aws_security_group" "dataplane_sg" {
  name   = "eks-dataplane_sg"
  vpc_id = aws_vpc.vpc.id
  tags = merge(var.tags,
    {
      Name = "Shahid-eda-dataplane-sg"
    }
  )

}
#Security group traffic rules for EKS 
##Ingress Rules
resource "aws_security_group_rule" "eks_nodes" {
  description       = "Allow pods to communicate with each other"
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  security_group_id = aws_security_group.dataplane_sg.id
  cidr_blocks       = flatten([var.pvtcidr, var.pubcidr])

}

resource "aws_security_group_rule" "eks_nodes_inbound" {
  description       = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  type              = "ingress"
  from_port         = 1025
  to_port           = 65535
  protocol          = "tcp"
  security_group_id = aws_security_group.dataplane_sg.id
  cidr_blocks       = flatten([var.pvtcidr])
}

#Egress Rules
resource "aws_security_group_rule" "eks_nodes_outbound" {
  security_group_id = aws_security_group.dataplane_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
}

#Security group for controlplane
resource "aws_security_group" "controlplane_sg" {
  name   = "eks-controlplane_sg"
  vpc_id = aws_vpc.vpc.id
  tags = merge(var.tags,
    {
      Name = "Shahid-eda-controlplane-sg"
    }
  )

}

#Security group traffic rules for EKS controlplane
##Ingress Rules
resource "aws_security_group_rule" "eks_api_server" {
  description       = "Allow pods running extension API servers on port 443 to receive communication from cluster control plane"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.controlplane_sg.id
  cidr_blocks       = flatten([var.pvtcidr, var.pubcidr])
}

#Egress Rules
resource "aws_security_group_rule" "eks_api_server_outbound" {
  security_group_id = aws_security_group.controlplane_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}