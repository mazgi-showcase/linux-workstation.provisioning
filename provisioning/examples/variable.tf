variable "base_dnsdomain" {
  default = "example.dev"
}

variable "aws_default_region" {
  default = "us-east-1"
}
variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "gcp_default_region" {
  default = "us-central1"
}
variable "gcp_project_id" {}
variable "project_unique_id" {}
