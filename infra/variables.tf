variable "aws_region" {
  default = "eu-north-1"
}

variable "cluster_name" {
  default = "luminor-dev-eks"
}

variable "project" {
  default = "luminor"
}

variable "vpc_cidr" {
  default = "10.10.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.10.1.0/24", "10.10.2.0/24"]
}
