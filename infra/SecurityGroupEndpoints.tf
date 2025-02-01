resource "aws_security_group" "vpc_endpoints" {
  name        = "${var.ambiante}-vpc-endpoints-sg"
  description = "Security group para VPC endpoints"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.privado.id]
  }

  tags = {
    Name        = "${var.ambiante}-vpc-endpoints-sg"
    Environment = var.ambiante
  }
}

resource "aws_security_group_rule" "privado_para_endpoints" {
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.privado.id
  source_security_group_id = aws_security_group.vpc_endpoints.id
} 