# nodes/outputs.tf

output "instance_id" {
  value = "${aws_instance.test_node.id}"
}
