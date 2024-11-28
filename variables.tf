variable "project_name" {
    description = "Name of the project"
    type = string
    default = "test-hackathon"
}

variable "region" {
    description = "AWS region in which a vpc will be provisioned"
    default = "us-east-1"
}

variable "env" {
    description = "env for which vpc to be provisioned"
    default = "dev"
}

variable "cidr_block" {
    description = "Subnet range to be used for VPC"
    default = "10.0.0.0/16"
}