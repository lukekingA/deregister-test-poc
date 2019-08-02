#  nodes/main.tf

provider "aws" {
  region = "${var.region}"
}


data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*-x86_64-gp2"]
  }
}

resource "aws_instance" "test_node" {
  ami           = "${data.aws_ami.amazon_linux.id}"
  instance_type = "t2.micro"

  associate_public_ip_address = "true"

  key_name = "${var.node_key_name}"

  vpc_security_group_ids = [
    "${var.test_node_vpc_security_group_id}"
  ]

  subnet_id = "${var.test_node_subnet_id}"

  tags = {
    Name = "test_node"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = "${file("~/.ssh/id_rsa")}"
    host        = "${self.public_ip}"
  }


  provisioner "file" {
    source      = "~/.ssh/id_rsa"
    destination = "/home/ec2-user/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 600 ~/.ssh/id_rsa"
    ]
  }
}

resource "null_resource" "clean_up" {
  provisioner "remote-exec" {
    when = "destroy"

    inline = [
      "echo '${join(", ", "${var.bind_list}")}' > /dev/null",
      "echo 'I made it out.' | ssh -i '/home/ec2-user/.ssh/id_rsa' ubuntu@${var.remote_ip} 'cat > /home/ubuntu/new_file.txt'"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${file("~/.ssh/id_rsa")}"
      host        = "${aws_instance.test_node.public_ip}"
    }
  }
}
