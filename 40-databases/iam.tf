resource "aws_iam_role" "mysql" {
    name = local.mysql_role_name #Roboshop-Dev-Mysql

    # Terraform's "jsoncode" function converts a 
    # Terraform expression result to valid JSON syntax.
    assume_role_policy = jsoncode({
        Version = 
        Statement = [
            {
                Action =""
                Effect = ""
                sid = ""
                Principal = {
                    Service =
                }
            },
        ]
    })

    tags = merge(
        {
            Name = local.mysql_role_name
        },
        local.common_tags
    )
}

resource "aws_iam_policy" "mysql" {
    name = "S3ReadOnlyAccessPolicy"
    description = "A policy for MySQL Ec2 instance"
    policy = file("mysql-iam-policy.json")
}
