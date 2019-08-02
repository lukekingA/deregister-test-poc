# modules/variables.tf

variable "node_key_name" {
  description = "The chef node key pair name for the public key you are using"
}

variable "region" {
  description = "The aws region that you are building this stack in"
  default     = "us-west-2"
}

variable "access_ip" {
  description = "The local ip the you are sshing into from"
}

variable "reomte_ip" {
  description = "The ip to ssh out in the destroy remote-exec"
}
