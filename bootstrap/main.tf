module "ecr" {
  source           = "./modules/ecr"
  image-name       = var.image-name
  image-mutability = var.image-mutability
}

module "s3" {
  source                   = "./modules/s3"
  bucket-name              = var.bucket-name
  bucket-name-tag          = var.bucket-name-tag
  object_ownership         = var.object_ownership
  sse_algorithm            = var.sse_algorithm
  versioning_configuration = var.versioning_configuration
}