############ Security Group #############
resource "aws_security_group" "GpSec-Linux" {
  name        = "GpSec-Linux"
  description = "Libera SSH e HTTP."
  vpc_id      = "vpc-08516a3959a04035f"

  #Liberar porta SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Liberar porta HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Liberar porta PING
  ingress {
    protocol    = "icmp"
    from_port   = 8
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

### GRUPO EC2 ####

data "template_file" "user_data" {
  template = file("./Scripts/script_debian.sh")
}

resource "aws_instance" "Linux" {
  ami                         = "ami-058bd2d568351da34" #Padrão da imagem vinda da AWS
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-035c4b4d6d825cee7"
  key_name                    = "terraform"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.GpSec-Linux.id]
  user_data                   = base64encode(data.template_file.user_data.rendered)

  tags = {
    Name = "Debian-Desafio"
  }
}

output "instance_public_ip" {
  description = "IP Publico da Instancia EC2"
  value       = aws_instance.Linux.public_ip
}