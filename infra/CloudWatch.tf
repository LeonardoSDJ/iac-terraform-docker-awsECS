resource "aws_cloudwatch_log_group" "django_logs" {
  name              = "/ecs/${var.ambiante}/django-api"
  retention_in_days = 30

  tags = {
    Environment = var.ambiante
    Application = "django-api"
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${var.ambiante}-cpu-utilization-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name        = "CPUUtilization"
  namespace          = "AWS/ECS"
  period             = "300"
  statistic          = "Average"
  threshold          = "80"
  alarm_description  = "Métrica de monitoramento de CPU alta"
  alarm_actions      = [aws_sns_topic.alerts.arn]

  dimensions = {
    ClusterName = module.ecs.ecs_cluster_name
    ServiceName = aws_ecs_service.django_service.name
  }
}

resource "aws_cloudwatch_metric_alarm" "memoria_alta" {
  alarm_name          = "${var.ambiante}-memory-utilization-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name        = "MemoryUtilization"
  namespace          = "AWS/ECS"
  period             = "300"
  statistic          = "Average"
  threshold          = "80"
  alarm_description  = "Métrica de monitoramento de memória alta"
  alarm_actions      = [aws_sns_topic.alerts.arn]

  dimensions = {
    ClusterName = module.ecs.ecs_cluster_name
    ServiceName = aws_ecs_service.django_service.name
  }
}

resource "aws_sns_topic" "alerts" {
  name = "${var.ambiante}-alerts"
} 