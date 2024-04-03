#Configuração do Terraform
terraform {
  required_version = ">=1.6.0"

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.42.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  shared_config_files = ["C:/Users/50579698890/.aws/config"]
  shared_credentials_files = ["C:/Users/50579698890/.aws/credentials"]

  default_tags {
    tags = {
        owner = "Gabi"
        managed-by = "Terraform"
    }
  }
}