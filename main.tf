provider "aws" {
      region = "us-east-1"
    }

    resource "aws_vpc" "main" {
      cidr_block = "10.0.0.0/16"
    }

    resource "aws_subnet" "subnet" {
      vpc_id     = aws_vpc.main.id
      cidr_block = "10.0.1.0/24"
    }

    resource "aws_security_group" "ecs" {
      vpc_id = aws_vpc.main.id

      ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }

      egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }

    resource "aws_ecs_cluster" "main" {
      name = "hello-world-cluster"
    }

    resource "aws_ecs_task_definition" "hello_world" {
      family                   = "hello-world-task"
      network_mode             = "awsvpc"
      requires_compatibilities = ["FARGATE"]
      cpu                      = "256"
      memory                   = "512"

      container_definitions = jsonencode([{
        name      = "hello-world-container"
        image     = "268724/hello-world-nodejs:latest"
        essential = true
        portMappings = [{
          containerPort = 3000
          hostPort      = 3000
        }]
      }])
    }

    resource "aws_ecs_service" "main" {
      name            = "hello-world-service"
      cluster         = aws_ecs_cluster.main.id
      task_definition = aws_ecs_task_definition.hello_world.arn
      desired_count   = 1
      launch_type     = "FARGATE"
      
      network_configuration {
        subnets          = [aws_subnet.subnet.id]
        security_groups  = [aws_security_group.ecs.id]
      }
    }

    output "cluster_name" {
      value = aws_ecs_cluster.main.name
    }

    output "service_name" {
      value = aws_ecs_service.main.name
    }