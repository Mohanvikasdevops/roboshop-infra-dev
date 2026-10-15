data "aws_ami" "joindevops" {
  most_recent      = true
  owners           = ["973714476881"]

  filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ssm_parameter" "catalogue_sg_id" {
    name = "/${var.project}/${var.environment}/catalogue_sg_id"
}

data "aws_ssm_parameter" "vpc_id" {
    name = "/${var.project}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project}/${var.environment}/private_subnet_ids"
}

data "aws_ssm_parameter" "backend_alb_listener_arn" {
    name = "/${var.project}/${var.environment}/backend_alb_listener_arn"
}

/* data "aws_ssm_parameter" "iam_instance_profile_name" {
  # Replace "iam_instance_profile_name" with the exact parameter name you used in your IAM component
  name = "/${var.project}/${var.environment}/iam_instance_profile_name"
} */