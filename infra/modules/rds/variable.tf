variable "project-name" {
  type = string
}

variable "cluster-name" {
  type = string
}

variable "private_subnets_ids" {
  type = list(string)
}

variable "rds_sg_id" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_engine" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "db_username" {
  type      = string
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}