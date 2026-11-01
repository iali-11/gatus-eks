resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.project-name}-db-subnet-group"
  subnet_ids = var.private_subnets_ids

  tags = {
    Name         = "${var.project-name}-db-subnet-group"
    project-name = var.project-name
  }
}

resource "aws_db_instance" "postgres" {
  identifier     = "${var.project-name}-postgres"
  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name                     = var.db_name
  username                    = var.db_username
  manage_master_user_password = true

  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [var.rds_sg_id]
  publicly_accessible    = false
  multi_az               = var.multi_az

  backup_retention_period    = var.backup_retention_period
  skip_final_snapshot        = true
  auto_minor_version_upgrade = true
  apply_immediately          = true
  deletion_protection        = false

  tags = {
    Name         = "${var.project-name}-postgres"
    project-name = var.project-name
  }
}