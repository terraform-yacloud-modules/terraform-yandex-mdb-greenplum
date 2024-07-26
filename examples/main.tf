module "greenplum_cluster" {
  source = "../"

  network_name        = "greenplum-network"
  subnet_name         = "greenplum-subnet"
  subnet_zone         = "ru-central1-a"
  subnet_cidr_blocks  = ["10.5.0.0/24"]
  security_group_name = "greenplum-sg"

  cluster_name        = "test-greenplum"
  cluster_description = "Test Greenplum cluster"
  environment         = "PRESTABLE"
  assign_public_ip    = true
  greenplum_version   = "6.22"

  master_host_count   = 2
  segment_host_count  = 5
  segment_in_host     = 1

  master_resources_preset = "s2.micro"
  master_disk_size        = 24
  master_disk_type        = "network-ssd"

  segment_resources_preset = "s2.micro"
  segment_disk_size        = 24
  segment_disk_type        = "network-ssd"

  access_web_sql = true

  greenplum_config = {
    max_connections                   = 395
    gp_workfile_compression           = "false"
  }

  user_name     = "admin_user"
  user_password = "your_super_secret_password"
}
