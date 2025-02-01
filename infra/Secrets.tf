resource "aws_secretsmanager_secret" "django_secrets" {
  name = "${var.ambiante}/django/secrets"
  
  tags = {
    Environment = var.ambiante
    Application = "django-api"
  }
}

resource "aws_secretsmanager_secret_version" "django_secrets_version" {
  secret_id = aws_secretsmanager_secret.django_secrets.id
  secret_string = jsonencode({
    DJANGO_SECRET_KEY = "change_me_in_production"
    DB_PASSWORD      = "change_me_in_production"
  })
} 