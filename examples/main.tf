data "yandex_client_config" "client" {}

module "network" {
  source = "git::https://github.com/terraform-yacloud-modules/terraform-yandex-vpc.git?ref=v1.0.0"

  folder_id = data.yandex_client_config.client.folder_id

  blank_name = "vpc-nat-gateway"
  labels = {
    repo = "terraform-yacloud-modules/terraform-yandex-vpc"
  }

  azs = ["ru-central1-a"]

  private_subnets = [["10.4.0.0/24"]]

  create_vpc         = true
  create_nat_gateway = true
}

module "greenplum_cluster" {
  source = "../"

  network_id          = module.network.vpc_id
  subnet_id           = module.network.private_subnets_ids[0]
  zone_id             = "ru-central1-a"

  cluster_name        = "test-greenplum"
  cluster_description = "Test Greenplum cluster"
  environment         = "PRODUCTION"
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
