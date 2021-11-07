# tessian-platform-interview-challenge

Output of terraform and openssl / curl of AWS LB.

## Terraform Output

```console
cwalshs-MacBook-Pro:terraform cwalsh$ terraform init

Initializing the backend...

Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Reusing previous version of hashicorp/tls from the dependency lock file
- Reusing previous version of hashicorp/aws from the dependency lock file
- Installing hashicorp/tls v3.1.0...
- Installed hashicorp/tls v3.1.0 (signed by HashiCorp)
- Installing hashicorp/aws v3.64.2...
- Installed hashicorp/aws v3.64.2 (signed by HashiCorp)

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
cwalshs-MacBook-Pro:terraform cwalsh$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_autoscaling_group.tessian will be created
  + resource "aws_autoscaling_group" "tessian" {
      + arn                       = (known after apply)
      + availability_zones        = (known after apply)
      + default_cooldown          = (known after apply)
      + desired_capacity          = (known after apply)
      + force_delete              = false
      + force_delete_warm_pool    = false
      + health_check_grace_period = 300
      + health_check_type         = (known after apply)
      + id                        = (known after apply)
      + launch_configuration      = "tessian"
      + max_size                  = 1
      + metrics_granularity       = "1Minute"
      + min_size                  = 1
      + name                      = "tessian"
      + name_prefix               = (known after apply)
      + protect_from_scale_in     = false
      + service_linked_role_arn   = (known after apply)
      + vpc_zone_identifier       = (known after apply)
      + wait_for_capacity_timeout = "10m"
    }

  # aws_ecs_cluster.tessian will be created
  + resource "aws_ecs_cluster" "tessian" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + name     = "tessian"
      + tags_all = {
          + "Environment" = "test"
          + "Owner"       = "cwalsh"
          + "Project"     = "tessian-platform-interview-challenge"
        }

      + setting {
          + name  = (known after apply)
          + value = (known after apply)
        }
    }

  # aws_ecs_service.tessian-platform-interview-challenge will be created
  + resource "aws_ecs_service" "tessian-platform-interview-challenge" {
      + cluster                            = (known after apply)
      + deployment_maximum_percent         = 200
      + deployment_minimum_healthy_percent = 100
      + desired_count                      = 1
      + enable_ecs_managed_tags            = false
      + enable_execute_command             = false
      + iam_role                           = (known after apply)
      + id                                 = (known after apply)
      + launch_type                        = "EC2"
      + name                               = "tessian-platform-interview-challenge"
      + platform_version                   = (known after apply)
      + scheduling_strategy                = "REPLICA"
      + tags_all                           = {
          + "Environment" = "test"
          + "Owner"       = "cwalsh"
          + "Project"     = "tessian-platform-interview-challenge"
        }
      + task_definition                    = (known after apply)
      + wait_for_steady_state              = false

      + load_balancer {
          + container_name   = "tessian-platform-interview-challenge"
          + container_port   = 8000
          + target_group_arn = (known after apply)
        }
    }

  # aws_ecs_task_definition.tessian-platform-interview-challenge will be created
  + resource "aws_ecs_task_definition" "tessian-platform-interview-challenge" {
      + arn                      = (known after apply)
      + container_definitions    = jsonencode(
            [
              + {
                  + cpu          = 10
                  + essential    = true
                  + image        = "cjwcsl/tessian-platform-interview-challenge:0.1"
                  + memory       = 128
                  + name         = "tessian-platform-interview-challenge"
                  + portMappings = [
                      + {
                          + containerPort = 8000
                        },
                    ]
                },
            ]
        )
      + family                   = "tessian-platform-interview-challenge"
      + id                       = (known after apply)
      + network_mode             = "bridge"
      + requires_compatibilities = [
          + "EC2",
        ]
      + revision                 = (known after apply)
      + tags_all                 = {
          + "Environment" = "test"
          + "Owner"       = "cwalsh"
          + "Project"     = "tessian-platform-interview-challenge"
        }
    }

  # aws_iam_instance_profile.ecs_agent will be created
  + resource "aws_iam_instance_profile" "ecs_agent" {
      + arn         = (known after apply)
      + create_date = (known after apply)
      + id          = (known after apply)
      + name        = "ecs-agent"
      + path        = "/"
      + role        = "ecs-agent"
      + tags_all    = {
          + "Environment" = "test"
          + "Owner"       = "cwalsh"
          + "Project"     = "tessian-platform-interview-challenge"
        }
      + unique_id   = (known after apply)
    }

  # aws_iam_role.ecs_agent will be created
  + resource "aws_iam_role" "ecs_agent" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "ec2.amazonaws.com"
                        }
                      + Sid       = ""
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "ecs-agent"
      + name_prefix           = (known after apply)
      + path                  = "/"
      + tags_all              = {
          + "Environment" = "test"
          + "Owner"       = "cwalsh"
          + "Project"     = "tessian-platform-interview-challenge"
        }
      + unique_id             = (known after apply)

      + inline_policy {
          + name   = (known after apply)
          + policy = (known after apply)
        }
    }

  # aws_iam_role_policy_attachment.ecs_agent will be created
  + resource "aws_iam_role_policy_attachment" "ecs_agent" {
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
      + role       = "ecs-agent"
    }

  # aws_iam_server_certificate.tessian_cert will be created
  + resource "aws_iam_server_certificate" "tessian_cert" {
      + arn              = (known after apply)
      + certificate_body = (known after apply)
      + expiration       = (known after apply)
      + id               = (known after apply)
      + name             = (known after apply)
      + name_prefix      = "tessian_test_cert"
      + path             = "/"
      + private_key      = (sensitive value)
      + tags_all         = {
          + "Environment" = "test"
          + "Owner"       = "cwalsh"
          + "Project"     = "tessian-platform-interview-challenge"
        }
      + upload_date      = (known after apply)
    }

  # aws_internet_gateway.internet_gateway will be created
  + resource "aws_internet_gateway" "internet_gateway" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags_all = {
          + "Environment" = "test"
          + "Owner"       = "cwalsh"
          + "Project"     = "tessian-platform-interview-challenge"
        }
      + vpc_id   = (known after apply)
    }

  # aws_launch_configuration.ecs will be created
  + resource "aws_launch_configuration" "ecs" {
      + arn                         = (known after apply)
      + associate_public_ip_address = true
      + ebs_optimized               = (known after apply)
      + enable_monitoring           = true
      + iam_instance_profile        = "ecs-agent"
      + id                          = (known after apply)
      + image_id                    = "ami-02cbbd18ed34c5898"
      + instance_type               = "t2.micro"
      + key_name                    = (known after apply)
      + name                        = "tessian"
      + name_prefix                 = (known after apply)
      + security_groups             = (known after apply)
      + user_data                   = "71a79d5bad3bbf55d08ca83240f5635c2ee22586"

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + no_device             = (known after apply)
          + snapshot_id           = (known after apply)
          + throughput            = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + throughput            = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_lb.default will be created
  + resource "aws_lb" "default" {
      + arn                        = (known after apply)
      + arn_suffix                 = (known after apply)
      + dns_name                   = (known after apply)
      + drop_invalid_header_fields = false
      + enable_deletion_protection = false
      + enable_http2               = true
      + id                         = (known after apply)
      + idle_timeout               = 60
      + internal                   = (known after apply)
      + ip_address_type            = (known after apply)
      + load_balancer_type         = "application"
      + name                       = "tessian"
      + security_groups            = (known after apply)
      + subnets                    = (known after apply)
      + tags_all                   = {
          + "Environment" = "test"
          + "Owner"       = "cwalsh"
          + "Project"     = "tessian-platform-interview-challenge"
        }
      + vpc_id                     = (known after apply)
      + zone_id                    = (known after apply)

      + subnet_mapping {
          + allocation_id        = (known after apply)
          + ipv6_address         = (known after apply)
          + outpost_id           = (known after apply)
          + private_ipv4_address = (known after apply)
          + subnet_id            = (known after apply)
        }
    }

  # aws_lb_listener.front_end will be created
  + resource "aws_lb_listener" "front_end" {
      + arn               = (known after apply)
      + id                = (known after apply)
      + load_balancer_arn = (known after apply)
      + port              = 80
      + protocol          = "HTTP"
      + ssl_policy        = (known after apply)
      + tags_all          = {
          + "Environment" = "test"
          + "Owner"       = "cwalsh"
          + "Project"     = "tessian-platform-interview-challenge"
        }

      + default_action {
          + order = (known after apply)
          + type  = "redirect"

          + redirect {
              + host        = "#{host}"
              + path        = "/#{path}"
              + port        = "443"
              + protocol    = "HTTPS"
              + query       = "#{query}"
              + status_code = "HTTP_301"
            }
        }
    }

  # aws_lb_listener.tessian will be created
  + resource "aws_lb_listener" "tessian" {
      + arn               = (known after apply)
      + certificate_arn   = (known after apply)
      + id                = (known after apply)
      + load_balancer_arn = (known after apply)
      + port              = 443
      + protocol          = "HTTPS"
      + ssl_policy        = (known after apply)
      + tags_all          = {
          + "Environment" = "test"
          + "Owner"       = "cwalsh"
          + "Project"     = "tessian-platform-interview-challenge"
        }

      + default_action {
          + order            = (known after apply)
          + target_group_arn = (known after apply)
          + type             = "forward"
        }
    }

  # aws_lb_target_group.tessian will be created
  + resource "aws_lb_target_group" "tessian" {
      + arn                                = (known after apply)
      + arn_suffix                         = (known after apply)
      + deregistration_delay               = "300"
      + id                                 = (known after apply)
      + lambda_multi_value_headers_enabled = false
      + load_balancing_algorithm_type      = (known after apply)
      + name                               = "tessian-target-group"
      + port                               = 80
      + preserve_client_ip                 = (known after apply)
      + protocol                           = "HTTP"
      + protocol_version                   = (known after apply)
      + proxy_protocol_v2                  = false
      + slow_start                         = 0
      + tags_all                           = {
          + "Environment" = "test"
          + "Owner"       = "cwalsh"
          + "Project"     = "tessian-platform-interview-challenge"
        }
      + target_type                        = "instance"
      + vpc_id                             = (known after apply)

      + health_check {
          + enabled             = (known after apply)
          + healthy_threshold   = (known after apply)
          + interval            = (known after apply)
          + matcher             = (known after apply)
          + path                = (known after apply)
          + port                = (known after apply)
          + protocol            = (known after apply)
          + timeout             = (known after apply)
          + unhealthy_threshold = (known after apply)
        }

      + stickiness {
          + cookie_duration = (known after apply)
          + cookie_name     = (known after apply)
          + enabled         = (known after apply)
          + type            = (known after apply)
        }
    }

  # aws_route_table.public will be created
  + resource "aws_route_table" "public" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = (known after apply)
              + instance_id                = ""
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = ""
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags_all         = {
          + "Environment" = "test"
          + "Owner"       = "cwalsh"
          + "Project"     = "tessian-platform-interview-challenge"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table_association.route_table_association[0] will be created
  + resource "aws_route_table_association" "route_table_association" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.route_table_association[1] will be created
  + resource "aws_route_table_association" "route_table_association" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.route_table_association[2] will be created
  + resource "aws_route_table_association" "route_table_association" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_security_group.ecs will be created
  + resource "aws_security_group" "ecs" {
      + arn                    = (known after apply)
      + description            = "Allow access to tessian container"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = []
              + description      = "Access from ecs lb"
              + from_port        = 1
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = (known after apply)
              + self             = false
              + to_port          = 65535
            },
        ]
      + name                   = "tessian-ecs"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags_all               = {
          + "Environment" = "test"
          + "Owner"       = "cwalsh"
          + "Project"     = "tessian-platform-interview-challenge"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_security_group.ecs_lb will be created
  + resource "aws_security_group" "ecs_lb" {
      + arn                    = (known after apply)
      + description            = "Allow access to tessian service"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "HTTP From internet"
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "HTTPS From internet"
              + from_port        = 443
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 443
            },
        ]
      + name                   = "tessian-ecs-alb"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags_all               = {
          + "Environment" = "test"
          + "Owner"       = "cwalsh"
          + "Project"     = "tessian-platform-interview-challenge"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_subnet.public[0] will be created
  + resource "aws_subnet" "public" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "eu-west-1a"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.0.1.0/24"
      + id                              = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = true
      + owner_id                        = (known after apply)
      + tags_all                        = {
          + "Environment" = "test"
          + "Owner"       = "cwalsh"
          + "Project"     = "tessian-platform-interview-challenge"
        }
      + vpc_id                          = (known after apply)
    }

  # aws_subnet.public[1] will be created
  + resource "aws_subnet" "public" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "eu-west-1b"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.0.2.0/24"
      + id                              = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = true
      + owner_id                        = (known after apply)
      + tags_all                        = {
          + "Environment" = "test"
          + "Owner"       = "cwalsh"
          + "Project"     = "tessian-platform-interview-challenge"
        }
      + vpc_id                          = (known after apply)
    }

  # aws_subnet.public[2] will be created
  + resource "aws_subnet" "public" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "eu-west-1c"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.0.3.0/24"
      + id                              = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = true
      + owner_id                        = (known after apply)
      + tags_all                        = {
          + "Environment" = "test"
          + "Owner"       = "cwalsh"
          + "Project"     = "tessian-platform-interview-challenge"
        }
      + vpc_id                          = (known after apply)
    }

  # aws_vpc.primary will be created
  + resource "aws_vpc" "primary" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "10.0.0.0/16"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = (known after apply)
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
      + tags_all                         = {
          + "Environment" = "test"
          + "Owner"       = "cwalsh"
          + "Project"     = "tessian-platform-interview-challenge"
        }
    }

  # tls_private_key.tessian_test will be created
  + resource "tls_private_key" "tessian_test" {
      + algorithm                  = "ECDSA"
      + ecdsa_curve                = "P384"
      + id                         = (known after apply)
      + private_key_pem            = (sensitive value)
      + public_key_fingerprint_md5 = (known after apply)
      + public_key_openssh         = (known after apply)
      + public_key_pem             = (known after apply)
      + rsa_bits                   = 2048
    }

  # tls_self_signed_cert.tessian_test will be created
  + resource "tls_self_signed_cert" "tessian_test" {
      + allowed_uses          = [
          + "key_encipherment",
          + "digital_signature",
          + "server_auth",
        ]
      + cert_pem              = (known after apply)
      + early_renewal_hours   = 0
      + id                    = (known after apply)
      + key_algorithm         = "ECDSA"
      + private_key_pem       = (sensitive value)
      + ready_for_renewal     = true
      + validity_end_time     = (known after apply)
      + validity_period_hours = 12
      + validity_start_time   = (known after apply)

      + subject {
          + common_name  = "tessian.cjwcsl.com"
          + organization = "CJWCSL"
        }
    }

Plan: 26 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + load_balancer_ip = (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

tls_private_key.tessian_test: Creating...
tls_private_key.tessian_test: Creation complete after 0s [id=9638dad52758d7ec08c51893560a90dd82dee500]
tls_self_signed_cert.tessian_test: Creating...
tls_self_signed_cert.tessian_test: Creation complete after 0s [id=240590988303680267290604488647619654671]
aws_iam_server_certificate.tessian_cert: Creating...
aws_vpc.primary: Creating...
aws_iam_role.ecs_agent: Creating...
aws_ecs_cluster.tessian: Creating...
aws_ecs_task_definition.tessian-platform-interview-challenge: Creating...
aws_ecs_task_definition.tessian-platform-interview-challenge: Creation complete after 0s [id=tessian-platform-interview-challenge]
aws_iam_server_certificate.tessian_cert: Creation complete after 1s [id=ASCAWKGKLY7UCRRSYQVSB]
aws_vpc.primary: Creation complete after 2s [id=vpc-0ef2c87438843e76b]
aws_internet_gateway.internet_gateway: Creating...
aws_subnet.public[1]: Creating...
aws_subnet.public[2]: Creating...
aws_subnet.public[0]: Creating...
aws_lb_target_group.tessian: Creating...
aws_security_group.ecs_lb: Creating...
aws_iam_role.ecs_agent: Creation complete after 2s [id=ecs-agent]
aws_iam_role_policy_attachment.ecs_agent: Creating...
aws_iam_instance_profile.ecs_agent: Creating...
aws_internet_gateway.internet_gateway: Creation complete after 0s [id=igw-09643108fb84dced6]
aws_route_table.public: Creating...
aws_lb_target_group.tessian: Creation complete after 1s [id=arn:aws:elasticloadbalancing:eu-west-1:434216093672:targetgroup/tessian-target-group/cc5a6971e2596b0c]
aws_iam_role_policy_attachment.ecs_agent: Creation complete after 1s [id=ecs-agent-20211107142206202900000002]
aws_route_table.public: Creation complete after 1s [id=rtb-0ceaedb001e062b46]
aws_iam_instance_profile.ecs_agent: Creation complete after 2s [id=ecs-agent]
aws_security_group.ecs_lb: Creation complete after 2s [id=sg-0239957eabcb9223c]
aws_security_group.ecs: Creating...
aws_security_group.ecs: Creation complete after 2s [id=sg-080e295498a5f278d]
aws_ecs_cluster.tessian: Still creating... [10s elapsed]
aws_ecs_cluster.tessian: Creation complete after 10s [id=arn:aws:ecs:eu-west-1:434216093672:cluster/tessian]
aws_launch_configuration.ecs: Creating...
aws_launch_configuration.ecs: Creation complete after 1s [id=tessian]
aws_subnet.public[2]: Still creating... [10s elapsed]
aws_subnet.public[1]: Still creating... [10s elapsed]
aws_subnet.public[0]: Still creating... [10s elapsed]
aws_subnet.public[2]: Creation complete after 11s [id=subnet-0d9d72def2384815a]
aws_subnet.public[0]: Creation complete after 11s [id=subnet-016bf8a790f423075]
aws_subnet.public[1]: Creation complete after 11s [id=subnet-053adf23f9b108039]
aws_route_table_association.route_table_association[1]: Creating...
aws_route_table_association.route_table_association[0]: Creating...
aws_route_table_association.route_table_association[2]: Creating...
aws_lb.default: Creating...
aws_autoscaling_group.tessian: Creating...
aws_route_table_association.route_table_association[0]: Creation complete after 0s [id=rtbassoc-011e76059727ff89e]
aws_route_table_association.route_table_association[2]: Creation complete after 0s [id=rtbassoc-0dea715998e121214]
aws_route_table_association.route_table_association[1]: Creation complete after 0s [id=rtbassoc-0cb4cdb4361d07160]
aws_lb.default: Still creating... [10s elapsed]
aws_autoscaling_group.tessian: Still creating... [10s elapsed]
aws_lb.default: Still creating... [20s elapsed]
aws_autoscaling_group.tessian: Still creating... [20s elapsed]
aws_lb.default: Still creating... [30s elapsed]
aws_autoscaling_group.tessian: Still creating... [30s elapsed]
aws_lb.default: Still creating... [40s elapsed]
aws_autoscaling_group.tessian: Still creating... [40s elapsed]
aws_autoscaling_group.tessian: Still creating... [50s elapsed]
aws_lb.default: Still creating... [50s elapsed]
aws_lb.default: Still creating... [1m0s elapsed]
aws_autoscaling_group.tessian: Still creating... [1m0s elapsed]
aws_autoscaling_group.tessian: Creation complete after 1m9s [id=tessian]
aws_lb.default: Still creating... [1m10s elapsed]
aws_lb.default: Still creating... [1m20s elapsed]
aws_lb.default: Still creating... [1m30s elapsed]
aws_lb.default: Still creating... [1m40s elapsed]
aws_lb.default: Still creating... [1m50s elapsed]
aws_lb.default: Still creating... [2m0s elapsed]
aws_lb.default: Still creating... [2m10s elapsed]
aws_lb.default: Still creating... [2m20s elapsed]
aws_lb.default: Creation complete after 2m23s [id=arn:aws:elasticloadbalancing:eu-west-1:434216093672:loadbalancer/app/tessian/8522f4a1ba4d5481]
aws_lb_listener.tessian: Creating...
aws_lb_listener.front_end: Creating...
aws_lb_listener.front_end: Creation complete after 0s [id=arn:aws:elasticloadbalancing:eu-west-1:434216093672:listener/app/tessian/8522f4a1ba4d5481/bfde763c6d57544b]
aws_lb_listener.tessian: Creation complete after 1s [id=arn:aws:elasticloadbalancing:eu-west-1:434216093672:listener/app/tessian/8522f4a1ba4d5481/94e915de76cf45f6]
aws_ecs_service.tessian-platform-interview-challenge: Creating...
aws_ecs_service.tessian-platform-interview-challenge: Creation complete after 0s [id=arn:aws:ecs:eu-west-1:434216093672:service/tessian/tessian-platform-interview-challenge]

Apply complete! Resources: 26 added, 0 changed, 0 destroyed.

Outputs:

load_balancer_ip = "tessian-1299190460.eu-west-1.elb.amazonaws.com"
```

## Curl (Check HTTP Redirect)
```console
cwalshs-MacBook-Pro:terraform cwalsh$ curl -D- -s -o /dev/null tessian-1299190460.eu-west-1.elb.amazonaws.com
HTTP/1.1 301 Moved Permanently
Server: awselb/2.0
Date: Sun, 07 Nov 2021 14:25:00 GMT
Content-Type: text/html
Content-Length: 134
Connection: keep-alive
Location: https://tessian-1299190460.eu-west-1.elb.amazonaws.com:443/
```

## Curl (Check HTTPS Works)
```console
cwalshs-MacBook-Pro:terraform cwalsh$ curl -D- -s -o /dev/null -k https://tessian-1299190460.eu-west-1.elb.amazonaws.com/api/emails/
HTTP/2 200
date: Sun, 07 Nov 2021 14:25:45 GMT
content-type: application/json
content-length: 2
server: WSGIServer/0.2 CPython/3.9.7
vary: Accept, Cookie
allow: GET, POST, HEAD, OPTIONS
x-frame-options: DENY
x-content-type-options: nosniff
referrer-policy: same-origin
```

## Openssl (Check TLS (Self-signed) Certificate)
```console
cwalshs-MacBook-Pro:terraform cwalsh$ openssl s_client -connect tessian-1299190460.eu-west-1.elb.amazonaws.com:443  | openssl x509 -text
depth=0 O = CJWCSL, CN = tessian.cjwcsl.com
verify error:num=20:unable to get local issuer certificate
verify return:1
depth=0 O = CJWCSL, CN = tessian.cjwcsl.com
verify error:num=21:unable to verify the first certificate
verify return:1
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            b5:00:23:8d:23:e0:8f:69:af:2e:0b:80:f8:48:34:0f
    Signature Algorithm: ecdsa-with-SHA384
        Issuer: O=CJWCSL, CN=tessian.cjwcsl.com
        Validity
            Not Before: Nov  7 14:22:02 2021 GMT
            Not After : Nov  8 02:22:02 2021 GMT
        Subject: O=CJWCSL, CN=tessian.cjwcsl.com
        Subject Public Key Info:
            Public Key Algorithm: id-ecPublicKey
                Public-Key: (384 bit)
                pub:
                    04:fd:a1:c4:3f:e6:5f:0e:a7:4a:66:dd:38:f7:5c:
                    c4:26:ae:8d:49:8c:46:f6:71:2f:33:9f:b9:a2:f8:
                    1a:36:d7:68:25:8f:40:c7:32:ab:95:61:a0:97:f9:
                    fd:b0:0d:54:17:d4:78:d9:29:1a:86:7f:a2:f3:d1:
                    8a:2b:9c:f9:4b:31:b2:75:1d:6a:37:5a:cd:01:22:
                    94:0d:75:4a:17:89:7c:61:ba:95:80:6e:bc:7e:ac:
                    0b:f5:40:fd:85:78:1c
                ASN1 OID: secp384r1
                NIST CURVE: P-384
        X509v3 extensions:
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
            X509v3 Extended Key Usage:
                TLS Web Server Authentication
            X509v3 Basic Constraints: critical
                CA:FALSE
    Signature Algorithm: ecdsa-with-SHA384
         30:65:02:31:00:e1:8e:c6:2e:d8:b7:37:c5:a6:87:12:1f:07:
         26:5f:d9:f9:14:1c:c9:7b:6b:f5:28:dc:8f:35:31:a2:e5:ce:
         be:0e:16:23:32:1c:34:30:ff:68:e8:69:c8:b1:c7:00:be:02:
         30:5c:33:30:61:43:21:fe:4d:74:1d:6e:91:c5:fa:ab:69:99:
         d0:03:4c:90:aa:e8:fe:9c:54:3a:60:39:4f:30:4d:6d:4d:0a:
         0d:c4:4f:15:cd:6b:89:5e:dc:47:fb:b8:b5
-----BEGIN CERTIFICATE-----
MIIBzTCCAVOgAwIBAgIRALUAI40j4I9pry4LgPhINA8wCgYIKoZIzj0EAwMwLjEP
MA0GA1UEChMGQ0pXQ1NMMRswGQYDVQQDExJ0ZXNzaWFuLmNqd2NzbC5jb20wHhcN
MjExMTA3MTQyMjAyWhcNMjExMTA4MDIyMjAyWjAuMQ8wDQYDVQQKEwZDSldDU0wx
GzAZBgNVBAMTEnRlc3NpYW4uY2p3Y3NsLmNvbTB2MBAGByqGSM49AgEGBSuBBAAi
A2IABP2hxD/mXw6nSmbdOPdcxCaujUmMRvZxLzOfuaL4GjbXaCWPQMcyq5VhoJf5
/bANVBfUeNkpGoZ/ovPRiiuc+UsxsnUdajdazQEilA11SheJfGG6lYBuvH6sC/VA
/YV4HKM1MDMwDgYDVR0PAQH/BAQDAgWgMBMGA1UdJQQMMAoGCCsGAQUFBwMBMAwG
A1UdEwEB/wQCMAAwCgYIKoZIzj0EAwMDaAAwZQIxAOGOxi7YtzfFpocSHwcmX9n5
FBzJe2v1KNyPNTGi5c6+DhYjMhw0MP9o6GnIsccAvgIwXDMwYUMh/k10HW6Rxfqr
aZnQA0yQquj+nFQ6YDlPME1tTQoNxE8VzWuJXtxH+7i1
-----END CERTIFICATE-----
```
