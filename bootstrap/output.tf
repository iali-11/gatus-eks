output "ecr_repo_url" {
  description = "URL of the ECR repository"
  value       = module.ecr.ecr-repo-url
}

output "s3-bucket-arn" {
  description = "The S3 bucket arn"
  value       = module.s3.s3-bucket-arn
}