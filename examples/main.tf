module "greenplum_cluster" {
  source = "../"

  network_id          = "xxx"
  subnet_id           = "xxx"
  zone_id             = "ru-central1-a"
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

  master_resources_preset = "s3-c8-m32"
  master_disk_size        = 93
  master_disk_type        = "network-ssd-nonreplicated"

  segment_resources_preset = "s3-c8-m32"
  segment_disk_size        = 93
  segment_disk_type        = "network-ssd-nonreplicated"

  access_web_sql = true

  greenplum_config = {
    max_connections                   = 395
    gp_workfile_compression           = "false"
  }

  user_name     = "admin_user"
  user_password = "your_super_secret_password"
}
