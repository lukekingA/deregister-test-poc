# nodes/variables.tf


variable "region" {
  description = " The aws region that you are setting up in."
  default     = "us-west-2"
}

variable "node_key_name" {
  description = "This is the private key name that allows ssh connection to the node instanc.e"
}

variable "test_node_vpc_security_group_id" {
  description = "The id of the security group to apply to the ec2."
}

variable "test_node_subnet_id" {
  description = "The id of the subnet in the chef nodes vpc."
}

variable "remote_ip" {
  description = "The ip to ssh out in the destroy remote-exec"
}

variable "bind_list" {
  description = "Dependancy binder"
  type        = "list"
  default     = []
}
