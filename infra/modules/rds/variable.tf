variable "project-name" {
  type = string
}

variable "private_subnets_ids" {
  type = list(string)
}

variable "rds_sg_id" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "max_allocated_storage" {
  type = number
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "multi_az" {
  type = bool
}

variable "backup_retention_period" {
  type = number
}