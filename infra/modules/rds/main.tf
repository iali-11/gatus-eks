resource "aws_db_subnet_group" "rds" {
  name       = "${var.project-name}-rds-subnet-group"
  subnet_ids = var.private_subnets_ids

  tags = {
    Name = "${var.project-name}-rds-subnet-group"
  }
}

resource "aws_db_instance" "postgres" {
  identifier        = "${var.cluster-name}-postgres"
  allocated_storage = var.allocated_storage
  db_name           = var.db_name
  engine            = var.db_engine
  instance_class    = var.instance_class
  username          = var.db_username
  password          = var.db_password

  db_subnet_group_name = aws_db_subnet_group.rds.name

  vpc_security_group_ids = [
    var.rds_sg_id
  ]

  publicly_accessible = false

  skip_final_snapshot = true
}
