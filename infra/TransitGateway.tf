resource "aws_ec2_transit_gateway" "main" {
  description = "Transit Gateway para ${var.ambiante}"
  
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  
  tags = {
    Name        = "${var.ambiante}-tgw"
    Environment = var.ambiante
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "main" {
  subnet_ids         = module.vpc.private_subnets
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  vpc_id             = module.vpc.vpc_id
  
  tags = {
    Name        = "${var.ambiante}-tgw-attachment"
    Environment = var.ambiante
  }
}

resource "aws_route" "private_tgw" {
  count                  = length(module.vpc.private_route_table_ids)
  route_table_id         = module.vpc.private_route_table_ids[count.index]
  destination_cidr_block = var.tgw_destination_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.main.id
} 