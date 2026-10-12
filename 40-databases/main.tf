resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id     = local.database_subnet_id
 vpc_security_group_ids = [local.mongodb_sg_id]

  tags = merge  (
        local.common_tags, 
        # roboshop-dev-mongodb
        {
            Name = "${var.project}-${var.environment}-mongodb"
        }
    )
}  

resource "terraform_data" "bootstrap" {
    triggers_replace = [
        aws_instance.mongodb.id
    ]

    connection {
        type = "ssh"
        user = "ec2-user"
        password = "DevOps321"
        host = aws_instance.mongodb.private_ip
    }

    provisioner "file" {
        source = "bootstrap.sh" # Local file path
        destination = "/tmp/bootstrap.sh" # Destination path on the remote machine
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/bootstrap.sh"
            "sudo sh /tmp/bootstrap.sh"
    }

resource "aws_iam_role_policy_attachment" "mongodb" {
  role       = aws_iam_role.mongodb.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Create the instance profile
resource "aws_iam_instance_profile" "mongodb" {
    name = "${var.project}.${var.environment}-mongodb"
    role = aws_iam_role.mongodb.name
}