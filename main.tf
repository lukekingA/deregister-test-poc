#modules/main.tf

module "network" {
  source    = "./network"
  access_ip = "${var.access_ip}"
}



module "nodes" {
  source                          = "./nodes"
  region                          = "${var.region}"
  node_key_name                   = "${var.node_key_name}"
  test_node_vpc_security_group_id = "${module.network.public_sg_id}"
  test_node_subnet_id             = "${module.network.test_subnet_id}"
  remote_ip                       = "${var.remote_ip}"
  bind_list = [
    "${module.network.test_public_rt_id}",
    "${module.network.public_rt_assoc_id}",
    "${module.network.test_private_rt_id}",
    "${module.network.public_sg_id}"
  ]
}


