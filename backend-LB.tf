#Create Load Balancer for Backend
resource "aws_lb" "back_end" {
    name = "backend-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [ aws_security_group.alb-backend-sg.id ]
    subnets = [ aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id ]
    tags = {
      Name = "ALB-Backend"
    }
    depends_on = [ aws_lb_target_group.front_end ]
}
#Create Load Balancer Listener HTTP for Backend
resource "aws_lb_listener" "back_end" {
    load_balancer_arn = aws_lb.back_end.arn
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.back_end.arn
    }
    depends_on = [ aws_lb_target_group.back_end ]
  
}

#Create Load Balancer Listener HTTPS for Backend
#resource "aws_lb_listener" "back_end" {
    #load_balancer_arn = aws_lb.back_end.arn
    #port = 443
    #protocol = "HTTPS"
    #ssl_policy = "ELBSecurityPolicy-2016-08"
    #certificate_arn = aws_acm_certificate.cert.arn
    #default_action {
      #type = "forward"
      #target_group_arn = aws_lb_target_group.back_end.arn
    #}
    #depends_on = [ aws_lb_target_group.back_end ]
  
#}