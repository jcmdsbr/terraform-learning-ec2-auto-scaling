resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_b.id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 5
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "admin"
  password             = "admin123*"
  parameter_group_name = "default.mysql5.7"
  availability_zone    = "${var.aws_region}a"
  skip_final_snapshot  = true

  db_subnet_group_name   = aws_db_subnet_group.default.id
  vpc_security_group_ids = [aws_security_group.db.id]
}