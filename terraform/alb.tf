resource "aws_lb" "default" {
  name            = "tessian"
  subnets         = aws_subnet.public.*.id
  security_groups = [aws_security_group.ecs_lb.id]
}

resource "aws_lb_target_group" "tessian" {
  name        = "tessian-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.primary.id
  #target_type = "ip"
}

resource "aws_lb_listener" "tessian" {
  load_balancer_arn = aws_lb.default.id
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_iam_server_certificate.tessian_cert.arn

  default_action {
    target_group_arn = aws_lb_target_group.tessian.id
    type             = "forward"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.default.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "tls_self_signed_cert" "tessian_test" {
  key_algorithm   = "ECDSA"
  private_key_pem = tls_private_key.tessian_test.private_key_pem

  subject {
    common_name  = "tessian.cjwcsl.com"
    organization = "CJWCSL"
  }

  validity_period_hours = 12

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "tls_private_key" "tessian_test" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "aws_iam_server_certificate" "tessian_cert" {
  name_prefix      = "tessian_test_cert"
  certificate_body = tls_self_signed_cert.tessian_test.cert_pem
  private_key      = tls_private_key.tessian_test.private_key_pem
  lifecycle {
    create_before_destroy = true
  }
}
