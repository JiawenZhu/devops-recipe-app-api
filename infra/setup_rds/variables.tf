variable "db_identifier" {
  description = "The name of the RDS instance"
  type        = string
}

variable "db_engine" {
  description = "The database engine"
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "The engine version"
  type        = string
  default     = "13.7"
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "The name of the database to create when the DB instance is created"
  type        = string
}

variable "db_username" {
  description = "Username for the master DB user"
  type        = string
}

variable "db_password" {
  description = "Password for the master DB user"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the DB instance will be created"
  type        = string
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket for RDS to access"
  type        = string
}
