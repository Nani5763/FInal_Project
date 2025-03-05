# Create Security Groups
resource "aws_security_group" "bastion-host" {
    name = "appserver-SG"
    description = "Allow inbound traffic from ALB"
    vpc_id = aws_vpc.three-tier.id
    depends_on = [ aws_vpc.three-tier ]
  
    ingress = [
        for port in [22, 8080, 9000, 9090, 3306, 80] : {
            description      = "TLS from VPC"
            from_port        = port
            to_port          = port
            protocol         = "tcp"
            ipv6_cidr_blocks = ["::/0"]
            self             = false
            prefix_list_ids  = []
            security_groups  = []
            cidr_blocks      = ["0.0.0.0/0"]
        }
    ]
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "bastion-host-server-sg"
    }
}
# ALB-frontend-sg
resource "aws_security_group" "alb-frontend-sg" {
    name = "alb-frontend-sg"
    description = "Allow inbound traffic from ALB"
    vpc_id = aws_vpc.three-tier.id
    depends_on = [ aws_vpc.three-tier ]

    ingress {
        description     = "http"
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        description     = "https"
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "alb-frontend-sg"
    }
  
}
# ALB-backend-sg
resource "aws_security_group" "alb-backend-sg" {
    name = "alb-backend-sg"
    description = "Allow inbound traffic ALB"
    vpc_id = aws_vpc.three-tier.id
    depends_on = [ aws_vpc.three-tier ]

    ingress {
        description     = "http"
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description     = "https"
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "alb-backend-sg"
    }
  
}
# Frontend server sg
resource "aws_security_group" "frontend-server-sg" {
    name = "frontend-server-sg"
    description = "Allow inbound traffic"
    vpc_id = aws_vpc.three-tier.id
    depends_on = [ aws_vpc.three-tier,aws_security_group.alb-frontend-sg ]

    ingress {
        description     = "http"
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description     = "ssh"
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "frontend-server-sg"
    }
  
}

# Backend server sg
resource "aws_security_group" "backend-server-sg" {
    name = "backend-server-sg"
    description = "Allow inbound traffic"
    vpc_id = aws_vpc.three-tier.id
    depends_on = [ aws_vpc.three-tier,aws_security_group.alb-backend-sg ]

    ingress {
        description     = "http"
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description     = "ssh"
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "backend-server-sg"
    }
    
}
# Database security group
resource "aws_security_group" "book-rds-sg" {
    name = "book-rds-sg"
    description = "Allow inbound"
    vpc_id = aws_vpc.three-tier.id
    depends_on = [ aws_vpc.three-tier ]

    ingress {
        description     = "mysql/aroura"
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "book-rds-sg"
    }
  
}