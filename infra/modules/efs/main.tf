resource "aws_efs_file_system" "efs" {
  creation_token = "${var.project-name}-efs"

  encrypted = true

  tags = {
    Name         = "${var.project-name}-efs"
    project-name = var.project-name
  }
}

resource "aws_efs_mount_target" "mount_target" {
  count           = length(var.private_subnets_ids)
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.private_subnets_ids[count.index]
  security_groups = [var.efs_sg_id]
}