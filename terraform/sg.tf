resource "aws_security_group" "ecs" {
  vpc_id      = aws_vpc.primary.id
  name        = "tessian-ecs"
  description = "Allow access to tessian container"

  ingress {
    description = "Access from ecs lb"
    from_port = 1
    to_port   = 65535
    protocol  = "tcp"
    security_groups = [ aws_security_group.ecs_lb.id ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ecs_lb" {
  vpc_id      = aws_vpc.primary.id
  name        = "tessian-ecs-alb"
  description = "Allow access to tessian service"

  ingress {
    description = "HTTP From internet"
    from_port = 80 
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS From internet"
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
