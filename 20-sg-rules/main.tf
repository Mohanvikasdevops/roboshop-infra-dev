resource "aws_security_group_rule" "bastion_internet" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  cidr_blocks              = [local.my_ip]
  # which security group to apply this rule
  security_group_id        = local.bastion_sg_id
}


resource "aws_security_group_rule" "mongodb_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  #where the traffic is coming from`
  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.mongodb_sg_id
}

resource "aws_security_group_rule" "mongodb_catalogue" {
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  #where the traffic is coming from`
  source_security_group_id = local.catalogue_sg_id
  security_group_id        = local.mongodb_sg_id
}

resource "aws_security_group_rule" "mongodb_user" {
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  #where the traffic is coming from`
  source_security_group_id = local.user_sg_id
  security_group_id        = local.mongodb_sg_id
}

resource "aws_security_group_rule" "redis_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"

  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.redis_sg_id
}

resource "aws_security_group_rule" "mysql_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"

  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.mysql_sg_id
}

resource "aws_security_group_rule" "rabbitmq_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"

  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.rabbitmq_sg_id
}

resource "aws_security_group_rule" "backend_alb_bastion" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"

  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "catalogue_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"

  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.catalogue_sg_id
}

resource "aws_security_group_rule" "catalogue_backend_alb_ingress" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  # This should reference the Backend ALB Security Group ID (which you likely have in a data source or local variable)
  source_security_group_id = local.backend_alb_sg_id 
  # This points to the catalogue security group shown in your image
  security_group_id        = local.catalogue_sg_id 
}

