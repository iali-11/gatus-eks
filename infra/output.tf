output "db_address" {
  value = module.rds.db_address
}

output "db_name" {
  value = module.rds.db_name
}

output "master_user_secret_arn" {
  value = module.rds.master_user_secret_arn
}