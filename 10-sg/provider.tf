terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "6.67.0"
        }
    }

    backend "s3" {
        bucket         = "roboshop-terraform-state-10"
        key            = "roboshop-dev-sg"
        region         = "us-east-1"
        encrypt        = true
        use_lockfile   = true
    }
}

provider "aws" {
    region = "us-east-1"
}