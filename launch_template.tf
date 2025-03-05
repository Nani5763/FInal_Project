# Fetch Frontend AMI
data "aws_ami" "frontend" {
    most_recent = true
    owners = ["self"] # Replace with the AWS account ID if needed

    filter {
      name = "name"
      values = [ "frontend-ami" ] # Use your AMI name pattern  
    }
 
}
# Create Launch Template Resource for Frontend
resource "aws_launch_template" "frontend" {
    name = "frontend-terraform"
    description = "frontend-terraform"
    image_id = data.aws_ami.frontend.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [ aws_security_group.frontend-server-sg.id ]
    key_name = "test-key-pair" #change the key
    user_data = filebase64("${path.module}/frontend-lt.sh")
    #default_version = 1
    update_default_version = true
    tag_specifications {
      resource_type = "instance"
      tags = {
        Name = "frontend-terraform"
      }
    }
}

#################################################################################################
# Fetch Backend AMI
data "aws_ami" "backend" {
    most_recent = true
    owners = [ "self" ] # Replace with the AWS account ID if needed

    filter {
      name = "name"
      values = [ "backend-ami" ] # Use your AMI name pattern
    }
  
}
#Create Launch Template Resource for Backend
resource "aws_launch_template" "backend" {
    name = "backend-terraform"
    description = "backend-terraform"
    image_id = data.aws_ami.backend.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [ aws_security_group.backend-server-sg.id ]
    key_name = "test-key-pair"
    user_data = filebase64("${path.module}/backend-lt.sh")
    # default_version = 1
    update_default_version = true
    tag_specifications {
      resource_type = "instance"
      tags = {
        Name = "backend-terraform"
      }
    }
}