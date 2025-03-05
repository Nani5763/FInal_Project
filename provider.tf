provider "aws" {  
  region = "us-east-1"
}
provider "aws" {
  alias  = "secondary"  
  region = "us-west-2"
}
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = ">= 5.25.0"
    }
  }

  backend "s3" {
    bucket = "pavanawsdevvvvvv"
    key    = "ec2/terraform.tfstate"
    region = "us-east-1"
  }

  required_version = ">= 1.6.3"
}