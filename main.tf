resource "yandex_mdb_greenplum_cluster" "greenplum_cluster" {
  name        = var.cluster_name
  description = var.cluster_description
  environment = var.environment
  network_id  = var.network_id
  zone        = var.zone_id
  subnet_id   = var.subnet_id
  version     = var.greenplum_version

  assign_public_ip   = var.assign_public_ip
  master_host_count  = var.master_host_count
  segment_host_count = var.segment_host_count
  segment_in_host    = var.segment_in_host

  master_subcluster {
    resources {
      resource_preset_id = var.master_resources_preset
      disk_size          = var.master_disk_size
      disk_type_id       = var.master_disk_type
    }
  }

  segment_subcluster {
    resources {
      resource_preset_id = var.segment_resources_preset
      disk_size          = var.segment_disk_size
      disk_type_id       = var.segment_disk_type
    }
  }

  access {
    web_sql = var.access_web_sql
  }

  user_name     = var.user_name
  user_password = var.user_password

  greenplum_config   = var.greenplum_config
  security_group_ids = var.security_group_ids
}
