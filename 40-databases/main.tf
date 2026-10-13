resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id     = local.database_subnet_id
 vpc_security_group_ids = [local.mmysql_sg_id]

  tags = merge  (
        local.common_tags, 
        # roboshop-dev-mongodb
        {
            Name = "${var.project}-${var.environment}-mongodb"
        }
    )
}  

resource "terraform_data" "mongodb" {

    depends_on = [
        aws_instance.mongodb
    ]

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
            "chmod +x /tmp/bootstrap.sh",
            "sudo sh /tmp/bootstrap.sh mongodb"
        ]    
    }
}

resource "aws_instance" "redis" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id     = local.database_subnet_id
 vpc_security_group_ids = [local.redis_sg_id]

  tags = merge  (
        local.common_tags, 
        # roboshop-dev-redis
        {
            Name = "${var.project}-${var.environment}-redis"
        }
    )
}  

resource "terraform_data" "redis" {

    depends_on = [
        aws_instance.redis
    ]

    triggers_replace = [
        aws_instance.redis.id
    ]

    connection {
        type = "ssh"
        user = "ec2-user"
        password = "DevOps321"
        host = aws_instance.redis.private_ip
    }

    provisioner "file" {
        source = "bootstrap.sh" # Local file path
        destination = "/tmp/bootstrap.sh" # Destination path on the remote machine
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/bootstrap.sh",
            "sudo sh /tmp/bootstrap.sh redis"
        ]    
    }
}

resource "aws_instance" "mysql" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id     = local.database_subnet_id
 vpc_security_group_ids = [local.mysql_sg_id]

  tags = merge  (
        local.common_tags, 
        # roboshop-dev-mysql
        {
            Name = "${var.project}-${var.environment}-mysql"
        }
    )
}  

resource "terraform_data" "mysql" {

    depends_on = [
        aws_instance.mysql
    ]

    triggers_replace = [
        aws_instance.mysql.id
    ]

    connection {
        type = "ssh"
        user = "ec2-user"
        password = "DevOps321"
        host = aws_instance.mysql.private_ip
    }

    provisioner "file" {
        source = "bootstrap.sh" # Local file path
        destination = "/tmp/bootstrap.sh" # Destination path on the remote machine
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/bootstrap.sh",
            "sudo sh /tmp/bootstrap.sh mysql"
        ]    
    }
}