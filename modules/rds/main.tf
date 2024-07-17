resource "random_password" "db_password" {
  length   = 20
}

resource "aws_ssm_parameter" "db_password" {
  name  = "/jayesh-poc/rds-password"
  type  = "SecureString"
  value = random_password.db_password.result
}

resource "aws_db_instance" "rds_instance" {
  identifier            = "mysql-db"
  allocated_storage     = var.allocated_storage
  storage_type          = "gp3"
  engine                = var.engine
  engine_version        = var.engine_version
  instance_class        = var.instance_class
  db_name               = "mydatabase"
  username              = var.username
  password              = aws_ssm_parameter.db_password.value
  tags = {
    Name        = "arc-training-rds"
    Environment = "arc_poc"
  }
}