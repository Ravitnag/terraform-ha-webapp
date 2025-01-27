resource "aws_security_group" "ha-webapp_instance" {
  name = "ha-webapp-instance"
  ingress {
    from_port       = var.listen_port_value
    to_port         = var.listen_port_value
    protocol        = "tcp"
    security_groups = [aws_security_group.ha-webapp_lb.id]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group" "ha-webapp_lb" {
  name = "ha-webapp-lb"
  ingress {
    from_port   = var.listen_port_value
    to_port     = var.listen_port_value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = module.vpc.vpc_id
}