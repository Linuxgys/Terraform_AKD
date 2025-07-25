variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "subnet2_cidr" {
  default = "10.0.2.0/24"
}

variable "availability_zone" {
  default = "ap-south-1a"
}

variable "availability_zone2" {
  default = "ap-south-1b"
}
