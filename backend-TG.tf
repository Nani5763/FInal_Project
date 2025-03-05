# Create Target Group for Backend Load Balancer
resource "aws_lb_target_group" "back_end" {
    name = "backend-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.three-tier.id
    depends_on = [ aws_vpc.three-tier ]
  
}