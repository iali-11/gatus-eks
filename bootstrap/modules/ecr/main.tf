resource "aws_ecr_repository" "gatus_image" {
  name                 = var.image-name
  image_tag_mutability = var.image-mutability

  image_scanning_configuration {
    scan_on_push = true
  }
}