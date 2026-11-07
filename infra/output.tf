output "db_address" {
  value = module.rds.db_address
}

output "db_name" {
  value = module.rds.db_name
}

output "db_secret_arn" {
  value = module.rds.db_secret_arn
}