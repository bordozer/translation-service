resource "aws_db_instance" "rds-db" {
  identifier = "mydbinstance"
  allocated_storage = "1"
  engine = "mysql"
  engine_version = "5.7.21"
  instance_class = "db.t2.micro"
  name = "${var.service_name}-db-${var.environment_name}"
  username = "admin"
  password = "${var.rds_password}"
  publicly_accessible = true
  vpc_security_group_ids = ["sg-03fc6d3d1c296f5a1"]
  skip_final_snapshot = true
}
