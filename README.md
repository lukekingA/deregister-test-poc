This a POC to show that you can structure dependancy in a terraform module structure to allow for ssh out before termination of an ec2.

* First there is an variable decalred in the the nodes module called bind_list. This is an empty list.
* Second in the node module main.tf in the remote-exec in the null_resource.clean_up list the first command is to echo a join of the bind_list to /dev/null
* Third in the network module outputs.tf ids of all needed network items are defined for output.
* Fourth in the main.tf at the top level in the module.node the bind_list is assigned the values output by the network module that we need to hang on to.

Using these output ids from the network module in the node module enforces the dependancy structure.
