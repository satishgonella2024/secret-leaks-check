resource "aws_security_group" "example" {
    name        = "example"
    description = "An example security group"

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]  # Open to the world
    }
}