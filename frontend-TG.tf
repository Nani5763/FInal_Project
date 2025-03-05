# Create Target Group for Frontend Load Balancer
resource "aws_lb_target_group" "front_end" {
    name = "frontend-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.three-tier.id
    depends_on = [ aws_vpc.three-tier ]
  
}