module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  name               = var.ambiante
  container_insights = true
  capacity_providers = ["FARGATE"]
  default_capacity_provider_strategy = [
    {
      capacity_provider = "FARGATE"
    }
  ]
}

resource "aws_ecs_task_definition" "Django-API" {
  family                   = "Django-API"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.cargo.arn
  task_role_arn           = aws_iam_role.cargo.arn
  container_definitions = jsonencode(
    [
      {
        "name"      = "producao"
        "image"     = "962752222089.dkr.ecr.us-west-2.amazonaws.com/producao:v1"
        "cpu"       = 256
        "memory"    = 512
        "essential" = true
        "secrets": [
          {
            "name": "DJANGO_SECRET_KEY",
            "valueFrom": "${aws_secretsmanager_secret.django_secrets.arn}:DJANGO_SECRET_KEY::"
          },
          {
            "name": "DB_PASSWORD",
            "valueFrom": "${aws_secretsmanager_secret.django_secrets.arn}:DB_PASSWORD::"
          }
        ],
        "portMappings" = [
          {
            "containerPort" = 8000
            "hostPort"      = 8000
          }
        ]
        "logConfiguration" = {
          "logDriver" = "awslogs"
          "options" = {
            "awslogs-group"         = aws_cloudwatch_log_group.django_logs.name
            "awslogs-region"        = "us-west-2"
            "awslogs-stream-prefix" = "ecs"
          }
        }
        "environment" = [
          {
            "name"  = "AWS_XRAY_DAEMON_ADDRESS"
            "value" = "xray-daemon:2000"
          }
        ]
      },
      {
        "name"      = "xray-daemon"
        "image"     = "amazon/aws-xray-daemon"
        "cpu"       = 32
        "memory"    = 256
        "essential" = true
        "portMappings" = [
          {
            "containerPort" = 2000
            "protocol"      = "udp"
          }
        ]
      }
    ]
  )
}


resource "aws_ecs_service" "Django-API" {
  name            = "Django-API"
  cluster         = module.ecs.ecs_cluster_id
  task_definition = aws_ecs_task_definition.Django-API.arn
  desired_count   = 3

  load_balancer {
    target_group_arn = aws_lb_target_group.alvo.arn
    container_name   = "producao"
    container_port   = 8000
  }

  network_configuration {
      subnets = module.vpc.private_subnets
      security_groups = [aws_security_group.privado.id]
  }

  capacity_provider_strategy {
      capacity_provider = "FARGATE"
      weight = 1 #100/100
  }
}