variable "aws_region" {
  type        = string
  description = "AWS Region"
}


variable "aws_instance_type" {
  type        = string
  description = "AWS Instance Type"
}

variable "aws_asg_min" {
  type        = string
  description = "AWS ASG Min Size"
}

variable "aws_asg_max" {
  type        = string
  description = "AWS ASG Max Size"
}

variable "ecs_service_desired_count" {
  type = string
  description = "The number of container instances to run"
}

variable "tessian_image" {
  type = string
  description = "The docker image"
}

variable "tessian_tag" {
  type = string
  description = "The docker image tag"
}

variable "aws_amis" {
  default = {
    eu-west-1      = "ami-02cbbd18ed34c5898"
  }
}
