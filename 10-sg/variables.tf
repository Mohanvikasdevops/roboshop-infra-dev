variable "project" {
    default = "roboshop"
    type = string
}

variable "environment" {
    default = "dev"
    type = string
}

variable "sg_name" {
    type = list(string)
     default = [
        # Databases
        "mongodb", "redis", "mysql", "rabbitmq",
        # Backend
         "catalogue", "user", "cart", "shipping", "payment",
         # Backend ALB
         "backend_alb",
        # Frontend
          "frontend",
         # Frontend ALB
         "frontend_alb",
        # Bastion
           "bastion"
        ]
}