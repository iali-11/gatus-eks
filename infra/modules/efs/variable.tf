variable "project-name" {
  type = string
}

variable "private_subnets_ids" {
  type = list(string)
}

variable "efs_sg_id" {
  type = string
}