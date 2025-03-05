resource "aws_instance" "back" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = aws_subnet.public-subnet-1.id
    vpc_security_group_ids = [ aws_security_group.bastion-host.id ]
    iam_instance_profile = aws_iam_instance_profile.instance-profile.name
    root_block_device {
      volume_size = 30
    }
    user_data = templatefile("./install-tools.sh", {})
    tags = {
      Name = "bastion-server"
    }

  
}