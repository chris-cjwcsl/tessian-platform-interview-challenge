resource "aws_ecs_cluster" "tessian" {
  name = "tessian"
}

resource "aws_launch_configuration" "ecs" {
    name                 = "tessian"
    image_id             = lookup(var.aws_amis, var.aws_region)
    iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
    security_groups      = [aws_security_group.ecs.id]
    user_data            = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.tessian.name} >> /etc/ecs/ecs.config"
    instance_type        = var.aws_instance_type
    associate_public_ip_address = "true"
}

resource "aws_autoscaling_group" "tessian" {
  name = "tessian"
  max_size                  = var.aws_asg_max
  min_size                  = var.aws_asg_min
  vpc_zone_identifier       = aws_subnet.public.*.id
  launch_configuration      = aws_launch_configuration.ecs.name
}

resource "aws_ecs_task_definition" "tessian-platform-interview-challenge" {
  family = "tessian-platform-interview-challenge"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  container_definitions = jsonencode([
    {
      name      = "tessian-platform-interview-challenge"
      image     = "${var.tessian_image}:${var.tessian_tag}"
      cpu       = 10
      memory    = 128
      essential = true
      portMappings = [
        {
          containerPort = 8000
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "tessian-platform-interview-challenge" {
  name            = "tessian-platform-interview-challenge"
  cluster         = aws_ecs_cluster.tessian.id
  task_definition = aws_ecs_task_definition.tessian-platform-interview-challenge.arn
  desired_count   = var.ecs_service_desired_count
  launch_type     = "EC2"

  load_balancer {
    target_group_arn = aws_lb_target_group.tessian.id
    container_name   = "tessian-platform-interview-challenge"
    container_port   = 8000
  }

  depends_on = [aws_lb_listener.tessian]
}
