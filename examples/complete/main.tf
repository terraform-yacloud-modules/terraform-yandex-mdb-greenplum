data "yandex_client_config" "client" {}

module "network" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-vpc.git?ref=v1.0.0"

  folder_id = data.yandex_client_config.client.folder_id

  blank_name = "greenplum-vpc-nat-gateway"
  labels = {
    repo = "terraform-yacloud-modules/terraform-yandex-vpc"
  }

  azs = ["ru-central1-a"]

  private_subnets = [["10.16.0.0/24"]]

  create_vpc         = true
  create_nat_gateway = true
}

module "greenplum_cluster" {
  source = "../../"

  network_id = module.network.vpc_id
  subnet_id  = module.network.private_subnets_ids[0]
  zone_id    = "ru-central1-a"

  cluster_name        = "test-greenplum"
  cluster_description = "Test Greenplum cluster"
  environment         = "PRODUCTION"
  assign_public_ip    = true
  greenplum_version   = "6.25"
  deletion_protection = false

  labels = {
    app = "test-greenplum"
  }

  master_host_count  = 2
  segment_host_count = 5
  segment_in_host    = 1

  master_resources_preset = "s3-c8-m32"
  master_disk_size        = 93
  master_disk_type        = "network-ssd-nonreplicated"

  segment_resources_preset = "s3-c8-m32"
  segment_disk_size        = 93
  segment_disk_type        = "network-ssd-nonreplicated"

  access_web_sql = true

  greenplum_config = {
    gp_add_column_inherits_table_setting = "true"
    gp_workfile_compression              = "false"
    gp_workfile_limit_files_per_query    = "10"
    gp_workfile_limit_per_segment        = "1048576"
    gp_workfile_limit_per_query          = "1048576"
    log_statement                        = "3" # LOG_STATEMENT_MOD
    max_connections                      = "250"
    max_prepared_transactions            = "350"
    max_slot_wal_keep_size               = "1048576"
    max_statement_mem                    = "134217728"
  }

  user_name     = "admin_user"
  user_password = "your_super_secret_password"

  maintenance_window = {
    type = "WEEKLY"
    day  = "MON"
    hour = 2
  }

  backup_window_start = {
    hours   = 2  # UTC
    minutes = 30 # UTC
  }

  pooler_config = {
    pooling_mode             = "SESSION"
    pool_size                = 100
    pool_client_idle_timeout = 600
  }

}
